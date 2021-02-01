//
//  LocalDataManager.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 30/1/21.
//

import Foundation

protocol LocalDataManager {
    func fetchAllNotebooks(completion: @escaping (Result<NotebookResponse?, Error>) -> ())
}
