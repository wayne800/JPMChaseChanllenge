//
//  NavigatorType.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation
import UIKit

typealias Completion = () -> Void

protocol Presentable {
    func toPresent() -> UIViewController
}

protocol NavigatorType: AnyObject, Presentable {
    var navController: UINavigationController { get }
    func setRootModule(_ module: Presentable, animated: Bool, completion: Completion?)
    func push(_ module: Presentable, animated: Bool, completion: Completion?)
    func present(_ module: Presentable, animated: Bool, completion: Completion?)
    func popModule()
    func dismissModule(animated: Bool)
    func dismissTopModule(animated: Bool)
    func createChild() -> NavigatorType
}
