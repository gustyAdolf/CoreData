//
//  NotebookViewModel.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 31/1/21.
//

import Foundation

protocol NotebookCoordinatorDelegate: class {
    
}

protocol NotebookViewDelegate: class {
    func notebooksFetched()
}

class NotebookViewModel {
    weak var coordinatorDelegate: NotebookCoordinatorDelegate?
    weak var viewDelegate: NotebookViewDelegate?
    let notebookDataManager: NotebookDataManager
    var ntViewModels: [NotebookCellViewModel] = []
    
    
    init(notebookDataManager: NotebookDataManager){
        self.notebookDataManager = notebookDataManager
    }
    
    fileprivate func fetchNotebooksAndReloadUI() {
        notebookDataManager.fetchAllNotebooks { [weak self] result in
            switch result {
                case .success(let notebookResult):
                    guard let notebooks = notebookResult?.notebooks else {return}
                    
                    self?.ntViewModels = notebooks.map({NotebookCellViewModel(notebook: $0)})
                    
                    self?.viewDelegate?.notebooksFetched()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func viewWasLoaded() {
        fetchNotebooksAndReloadUI()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func viewModel(at indexPath: IndexPath) -> NotebookCellViewModel? {
        guard indexPath.row < ntViewModels.count else {return nil}
        return ntViewModels[indexPath.row]
    }
    
    func numberOfRows(in section: Int) -> Int {
        return ntViewModels.count
    }
}
