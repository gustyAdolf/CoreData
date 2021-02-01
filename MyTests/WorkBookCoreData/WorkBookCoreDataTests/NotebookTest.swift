//
//  WorkBookCoreDataTests.swift
//  WorkBookCoreDataTests
//
//  Created by Gustavo A Ramírez Franco on 29/1/21.
//

import XCTest
@testable import WorkBookCoreData
import CoreData

class NotebookTest: XCTestCase {
    private let modelName = "WorkBookCoreData"
    private let storeName = "NotebookTEST"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        let dataController = DataController(modelName: modelName, optionalStoreName: storeName) { (_) in }
        dataController.delete()
    }
    
    // MARK: - TESTS
    /// Can init our DataController
    func testInitDataController() {
        DataController(modelName: modelName, optionalStoreName: storeName) { (_) in
            XCTAssert(true)
        }
    }
    
    /// Can create a Notebook, without persist
    func testCreatSingleNotebook() {
        DataController(modelName: modelName, optionalStoreName: storeName) { (persistentContainer) in
            guard let persistentContainer = persistentContainer else {
                XCTFail()
                return
            }
            let managedObjectContext = persistentContainer.viewContext
            
            let notebook1 = NotebookMO.createNotebook(managedObjectContext: managedObjectContext, title: "Notebook 1", createdAt: Date())
            
            XCTAssertNotNil(notebook1)
        }
        
    }
    
    /// Can fetch Notebooks
    func testFetchNotebooks() {
        let dataController = DataController(modelName: modelName, optionalStoreName: storeName) { (persistentContainer) in
            guard let persistentContainer = persistentContainer else {
                XCTFail()
                return
            }
            let managedObjectContext = persistentContainer.viewContext
            
            NotebookMO.createNotebook(managedObjectContext: managedObjectContext, title: "Notebook 1", createdAt: Date())
            NotebookMO.createNotebook(managedObjectContext: managedObjectContext, title: "Notebook 2", createdAt: Date())
            
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        let notebooks = dataController.fetch(using: fetchRequest) as? [NotebookMO]
        
        XCTAssertEqual(notebooks?.count, 2)
    }
    
    /// Can create and persist a Notebook
    func testPersistSingleNotebook() {
        let dataController = DataController(modelName: modelName, optionalStoreName: storeName) { (persistentContainer) in
            guard let persistentContainer = persistentContainer else {
                XCTFail()
                return
            }
            let managedObjectContext = persistentContainer.viewContext
            
            NotebookMO.createNotebook(managedObjectContext: managedObjectContext, title: "Notebook 1", createdAt: Date())
            NotebookMO.createNotebook(managedObjectContext: managedObjectContext, title: "Notebook 2", createdAt: Date())
        }
        dataController.save()
        dataController.reset()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        let notebooks = dataController.fetch(using: fetchRequest) as? [NotebookMO]
        XCTAssertEqual(notebooks?.count, 2)
    }
    
    
    /// Can sort notebooks
    func testFetchAndSortNotebooks() {
        let dataController = DataController(modelName: modelName, optionalStoreName: storeName) { (persistentContainer) in
            guard let persistentContainer = persistentContainer else {
                XCTFail()
                return
            }
            let managedObjectContext = persistentContainer.viewContext
            
            NotebookMO.createNotebook(managedObjectContext: managedObjectContext, title: "Notebook 1", createdAt: Date())
            NotebookMO.createNotebook(managedObjectContext: managedObjectContext, title: "Notebook 2", createdAt: Date())
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notebook")
        let sortDesc = NSSortDescriptor(key: "title", ascending: false)
        fetchRequest.sortDescriptors = [sortDesc]
        
        let notebooks = dataController.fetch(using: fetchRequest) as? [NotebookMO]
        
        XCTAssertEqual(notebooks?.first?.title, "Notebook 2")
        
    }
}
