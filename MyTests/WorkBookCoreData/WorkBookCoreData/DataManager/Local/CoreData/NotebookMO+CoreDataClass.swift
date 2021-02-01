//
//  NotebookMO+CoreDataClass.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 29/1/21.
//
//

import Foundation
import CoreData


public class NotebookMO: NSManagedObject {

    @discardableResult
    static func createNotebook(managedObjectContext: NSManagedObjectContext,
                           title: String,
                           createdAt: Date) -> NotebookMO? {
        let notebook = NSEntityDescription.insertNewObject(forEntityName: "Notebook", into: managedObjectContext) as? NotebookMO
        notebook?.title = title
        notebook?.createdAt = createdAt
        return notebook
    }
    
    static var format: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    static func textFrom(date: Date) -> String {
        return format.string(from: date)
    }
}
