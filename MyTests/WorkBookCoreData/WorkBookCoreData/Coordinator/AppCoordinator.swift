//
//  AppCoordinator.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 30/1/21.
//

import UIKit

class AppCoordinator: Coordinator {
    
    lazy var localDataManager: LocalDataManager = {
       return LocalDataManagerImpl()
    }()
    
    lazy var dataManager: ClientDataManager = {
        return ClientDataManager(localDataManager: self.localDataManager)
    }()
    
    let window: UIWindow
    
    init(window: UIWindow){
        self.window = window
    }
    
    override func start() {
        let notebookNavController = UINavigationController()
        let notebookCoordinator = NotebookCoordinator(presenter: notebookNavController, notebookDataManager: dataManager)
        addChildCoordinator(notebookCoordinator)
        notebookCoordinator.start()
        
        window.rootViewController = notebookNavController
        window.makeKeyAndVisible()
        
    }
    
    override func finish() {}
}
