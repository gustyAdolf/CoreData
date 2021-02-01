//
//  NotebookResponse.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 31/1/21.
//

import Foundation

struct NotebookResponse: Codable {
    let notebooks: [Notebook]
    
    enum CodingKeys: String, CodingKey {
        case notebooks
    }
}

struct Notebook: Codable {
    let title: String
    let createdAt: Date
        
    enum CodingKeys: String, CodingKey {
        case title
        case createdAt = "created_at"
    }
}
