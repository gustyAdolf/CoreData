//
//  NotebookCoordinator.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 31/1/21.
//

import UIKit

class NotebookCoordinator: Coordinator {
    let presenter: UINavigationController
    let notebookDataManager: NotebookDataManager
    var notebookViewModel: NotebookViewModel?
    
    init(presenter: UINavigationController, notebookDataManager: NotebookDataManager) {
        self.presenter = presenter
        self.notebookDataManager = notebookDataManager
    }
    
    override func start() {
        let notebookViewModel = NotebookViewModel(notebookDataManager: notebookDataManager)
        let notebookViewController = NotebookViewController(viewModel: notebookViewModel)
        
        notebookViewController.title = NSLocalizedString("Notebooks", comment: "")
        notebookViewModel.viewDelegate = notebookViewController
        notebookViewModel.coordinatorDelegate = self
        self.notebookViewModel = notebookViewModel
        presenter.pushViewController(notebookViewController, animated: false)
    }
    
    override func finish() {
        
    }
}

// MARK: - Extension Coordinator Delegate

extension NotebookCoordinator: NotebookCoordinatorDelegate {
    
}
