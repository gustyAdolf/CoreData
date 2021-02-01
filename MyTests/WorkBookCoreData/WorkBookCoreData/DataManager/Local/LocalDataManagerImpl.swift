//
//  LocalDataManagerImpl.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 30/1/21.
//

import Foundation
import CoreData

/// Implementacion por defecto
final class LocalDataManagerImpl: LocalDataManager {
    
    var dataController = DataController(modelName: "WorkBookCoreData", optionalStoreName: nil) { _ in  }
    
    func fetchAllNotebooks(completion: @escaping (Result<NotebookResponse?, Error>) -> ()) {
        // Create 3 notebooks
        createNotebooks(n: 3, managedObjectContext: dataController.viewContext)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        let notebooks = dataController.fetch(using: fetchRequest) as? [NotebookMO]
        
        var arrayOfNt: [Notebook] = []
        notebooks?.forEach({ (notebook) in
            let nt = Notebook(title: notebook.title ?? "", createdAt: notebook.createdAt ?? Date())
            arrayOfNt.append(nt)
        })
        DispatchQueue.main.async {
            completion(.success(NotebookResponse(notebooks: arrayOfNt)))
        }
    }
    
 
    // MARK: - Private functions
    private func createNotebooks(n numberOfNotebooks: Int, managedObjectContext: NSManagedObjectContext) {
        for i in 1...numberOfNotebooks {
            NotebookMO.createNotebook(managedObjectContext: managedObjectContext, title: "Notebook \(i)", createdAt: Date())
        }
    }
    
}
