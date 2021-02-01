//
//  NotebookDataManager.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 31/1/21.
//

import Foundation

protocol NotebookDataManager {
    func fetchAllNotebooks(completion: @escaping (Result<NotebookResponse?, Error>) -> ())
}
