//
//  DataController.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 29/1/21.
//

import CoreData

class DataController: NSObject {
    
    private let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Instantiation of DataController creating coreData Stack
    @discardableResult
    init(modelName: String, optionalStoreName: String?, completion: @escaping (NSPersistentContainer?) -> ()) {
        
        if let optionalStoreName = optionalStoreName {
            let managedObjectModel = Self.managedObjectModel(with: modelName)
            self.persistentContainer = NSPersistentContainer(name: optionalStoreName, managedObjectModel: managedObjectModel)
            super.init()
            self.persistentContainer.loadPersistentStores { [weak self] (description, error) in
                if let error = error {
                    fatalError("Couldn't load CoreData Stack \(error.localizedDescription)")
                }
                completion(self?.persistentContainer)
            }
        } else {
            self.persistentContainer = NSPersistentContainer(name: modelName)
            super.init()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.persistentContainer.loadPersistentStores(completionHandler: { [weak self] (description, error) in
                    if let error = error {
                        fatalError("Couldn't load CoreData Stack \(error.localizedDescription)")
                    }
                    DispatchQueue.main.async {
                        completion(self?.persistentContainer)
                    }
                })
            }
        }
    }
    
    // MARK: - ManagedObjectModel
    /// Create managedObjectModel from model created xcdatamodeld
    static func managedObjectModel(with name: String) -> NSManagedObjectModel {
        guard let modelURL = Bundle.main.url(forResource: name, withExtension: "momd") else {fatalError("Error could not find model.")}
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {fatalError("Error initializing managedObjectModel from: \(modelURL)")}
        return managedObjectModel
    }
    
    // MARK: - CRUD
    
    /// FETCH
    func fetch(using fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> Any? {
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            fatalError("Failure to fetch with context: \(fetchRequest), \(error)")
        }
    }
    /// SAVE
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("=== Could not save view context ===")
            print("error: \(error.localizedDescription)")
        }
    }
    /// DELETE (delete persisted data)
    func delete() {
        guard let persistentStoreUrl = persistentContainer.persistentStoreCoordinator.persistentStores.first?.url else {return}
        do {
            try persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: persistentStoreUrl, ofType: NSSQLiteStoreType, options: nil)
        } catch {
            fatalError("Could not delete database. \(error.localizedDescription)")
        }
    }
    
    /// RESET (for non persistent data)
    func reset() {
        viewContext.reset()
    }
}
