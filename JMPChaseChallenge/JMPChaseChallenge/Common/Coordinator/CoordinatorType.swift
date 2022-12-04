//
//  CoordinatorType.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation

typealias UICoordinator = BaseCoordinator & CoordinatorType

protocol CoordinatorType where Self: BaseCoordinator {
    var currentTopCoordinator: UICoordinator { get }
    func start()
    func finish()
    func coordinate(to coordinator: UICoordinator)
}
