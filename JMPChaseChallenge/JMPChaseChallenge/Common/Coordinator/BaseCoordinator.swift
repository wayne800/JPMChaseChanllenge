//
//  Coordinator.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation

import Foundation

class BaseCoordinator {
    // MARK: - Properites
    
    fileprivate(set) var parent: UICoordinator?
    fileprivate var children: [UICoordinator]
    
    // MARK: - Initialization
    
    init(parent: UICoordinator? = nil, children: [UICoordinator] = []) {
        self.parent = parent
        self.children = children
    }
    
    deinit {
        print("[Coordinator] 💥 \(String(describing: self)) -> deinit")
    }
}

extension BaseCoordinator {
    func addChild(_ coordinator: UICoordinator) {
        if !children.contains(where: { $0 === coordinator }) {
            children.append(coordinator)
        }
    }
    
    func removeChild(_ coordinator: UICoordinator) {
        if let idx = children.firstIndex(where: { $0 === coordinator }) {
            children.remove(at: idx)
        }
    }
    
    func removeAllChildren() {
        print("[Coordinator] 🟡 \(String(describing: self)) -> remove all childrens \(children)")
        children.removeAll()
    }
}

extension CoordinatorType where Self: BaseCoordinator {
    var currentTopCoordinator: UICoordinator {
        var presented: UICoordinator = self

        while let last = presented.children.last {
            presented = last
        }

        return presented
    }
    
    func coordinate(to coordinator: UICoordinator) {
        print("[Coordinator] 🟢 \(String(describing: coordinator)) -> start")
        addChild(coordinator)
        coordinator.parent = self
        coordinator.start()
    }
    
    func finish() {
        print("[Coordinator] 🟡 \(String(describing: self)) -> finish")
        parent?.removeChild(self)
    }
}
