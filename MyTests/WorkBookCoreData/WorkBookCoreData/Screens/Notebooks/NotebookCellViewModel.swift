//
//  NotebookCellViewModel.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 31/1/21.
//

import Foundation

class NotebookCellViewModel {
    var format: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    var title: String?
    var createdAt: String?
    
    init(notebook: Notebook) {
        self.title = notebook.title
        self.createdAt = textFrom(date: notebook.createdAt)
    }
    
    // MARK: - Private functions
    private func textFrom(date: Date) -> String {
        return format.string(from: date)
    }
}
