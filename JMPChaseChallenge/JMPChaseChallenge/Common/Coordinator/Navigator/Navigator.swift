//
//  Navigator.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation
import UIKit

/*
 * This class is the backbone of each coordinator.
 * It allows the coordinator to handle its own navigation stack.
 */
final class Navigator: NSObject, NavigatorType {
    
    // MARK: Properties
    
    var navController: UINavigationController
    private weak var parent: NavigatorType?
    private var completions: [UIViewController: Completion]
    
    // MARK: Initializations
    
    init(navController: UINavigationController, parent: NavigatorType?) {
        self.navController = navController
        self.parent = parent
        self.completions = [:]
        
        super.init()
        navController.delegate = self
    }
    
    convenience init(
        navController: UINavigationController = UINavigationController(),
        presentStyle: UIModalPresentationStyle = .fullScreen,
        hideBar: Bool = false,
        parent: NavigatorType?) {
            navController.modalPresentationStyle = presentStyle
            navController.isNavigationBarHidden = hideBar
            
            self.init(navController: navController, parent: parent)
    }
    
    // MARK: private func
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }

        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK: - conform NavigationType

extension Navigator {
    // Return the uinavigation controller
    public func toPresent() -> UIViewController {
        navController
    }
    
    func setRootModule(_ module: Presentable, animated: Bool, completion: Completion?) {
        let viewController = module.toPresent()
        completions.forEach{ $0.value() }
        completions.removeAll()
        navController.setViewControllers([viewController], animated: animated)
        if let completion = completion {
            completions[viewController] = completion
        }
    }
    
    func present(_ module: Presentable, animated: Bool, completion: Completion?) {
        if let parent = parent,
           navController.viewControllers.isEmpty {
            setRootModule(module, animated: animated, completion: completion)
            navController.presentationController?.delegate = self
            completions[module.toPresent()] = completion
            parent.present(self, animated: animated, completion: completion)
        } else {
            let controller = module.toPresent()
            navController.present(controller, animated: animated)
        }
    }
    
    func push(_ module: Presentable, animated: Bool, completion: Completion?) {
        let controller = module.toPresent()
        
        guard controller is UINavigationController == false else {
            return
        }
        
        if let completion = completion {
            completions[controller] = completion
        }
        navController.pushViewController(controller, animated: animated)
    }
    
    func popModule() {
        guard let controller = navController.popViewController(animated: true) else {
            return
        }
        
        runCompletion(for: controller)
    }
    
    func dismissTopModule(animated: Bool) {
        var topController: UIViewController?
        
        if let controller = navController.presentedViewController {
            while let topPresented = controller.presentedViewController {
                topController = topPresented
            }
            
            if let controller = topController {
                controller.dismiss(animated: animated)
                runCompletion(for: controller)
            }
        }
    }
    
    func dismissModule(animated: Bool) {
        navController.dismiss(animated: animated)
        
        completions.forEach {[weak self] in
            self?.runCompletion(for: $0.key)
        }
    }
    
    func createChild() -> NavigatorType {
        Navigator(parent: self)
    }
}

// Check completions for dismissed ViewControllers
extension Navigator: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let navController = presentationController.presentedViewController as? UINavigationController {
            navController.viewControllers.reversed().forEach { controller in
                runCompletion(for: controller)
            }
        } else {
            runCompletion(for: presentationController.presentedViewController)
        }
    }
}

// Check completions for poped ViewControllers
extension Navigator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let viewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(viewController) else {
            return
        }
        
        if let completion = completions[viewController] {
            completion()
        }
    }
}

