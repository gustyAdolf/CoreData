//
//  NotebookTableViewCell.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 31/1/21.
//

import UIKit

class NotebookTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var createdAt: UILabel!
    
    var viewModel: NotebookCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            title.text = viewModel.title
            createdAt.text = viewModel.createdAt
        }
    }
}
