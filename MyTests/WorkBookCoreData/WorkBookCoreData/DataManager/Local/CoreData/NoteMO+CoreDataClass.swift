//
//  NoteMO+CoreDataClass.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 29/1/21.
//
//

import Foundation
import CoreData

@objc(NoteMO)
public class NoteMO: NSManagedObject {

    @discardableResult
    static func createNote(managedObjectContext: NSManagedObjectContext,
                           notebook: NotebookMO,
                           title: String,
                           createdAt: Date,
                           contains: String?) -> NoteMO? {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedObjectContext) as? NoteMO
        note?.title = title
        note?.createdAt = createdAt
        note?.contains = contains
        return note
    }
}
