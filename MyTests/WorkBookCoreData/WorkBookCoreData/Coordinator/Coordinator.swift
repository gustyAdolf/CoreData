//
//  Coordinator.swift
//  WorkBookCoreData
//
//  Created by Gustavo A Ramírez Franco on 30/1/21.
//

import Foundation

class Coordinator {
    fileprivate var childCoordinator: [Coordinator] = []
    
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass")
    }
    
    func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass")
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinator.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinator.firstIndex(of: coordinator) {
            childCoordinator.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinator = childCoordinator.filter { $0 is T == false }
    }
    
    func removeAllChildCoordinators() {
        childCoordinator.removeAll()
    }
}

// MARK: - Extension Equatable
extension Coordinator: Equatable {

    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }

}
