//
//  NoteResponse.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 31/1/21.
//

import Foundation

struct NoteResponse: Codable {
    let notebook: Notebook
    let notes: [Note]
    
    enum CodingKeys: String, CodingKey {
        case notebook, notes
    }
}

struct Note: Codable {
    let title: String
    let createdAt: String
    let contains: String
    
    enum CodingKeys: String, CodingKey {
        case title, contains
        case createdAt = "created_at"
    }
    
}
