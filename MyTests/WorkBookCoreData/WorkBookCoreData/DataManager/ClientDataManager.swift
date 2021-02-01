//
//  ClientDataManager.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 31/1/21.
//

import Foundation

class ClientDataManager {
    let localDataManager: LocalDataManager
    
    init(localDataManager: LocalDataManager) {
        self.localDataManager = localDataManager
    }
}

// MARK: - DATA MANAGER EXTENSIONS

// MARK: - NotebookDataManager
extension ClientDataManager: NotebookDataManager {
    func fetchAllNotebooks(completion: @escaping (Result<NotebookResponse?, Error>) -> ()) {
        localDataManager.fetchAllNotebooks(completion: completion)
    }
}
