//
//  AppCoordinator.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import UIKit

protocol AppCoordinatorInput: AnyObject {
    func coordinateToMain()
}

final class AppCoordinator: UICoordinator {
    private let appEnvironment: AppEnvironment
    private let navigator: NavigatorType
    private let window: UIWindow?
    
    init(appEnvironment: AppEnvironment, navigator: NavigatorType, window: UIWindow?) {
        self.appEnvironment = appEnvironment
        self.navigator = navigator
        self.window = window
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "AppViewController") as? AppViewController {
            controller.coordinator = self
            navigator.setRootModule(controller, animated: true, completion: nil)
            window?.rootViewController = navigator.toPresent()
        }
    }
}

extension AppCoordinator: AppCoordinatorInput {
    func coordinateToMain() {
        let schoolEnvironment = SchoolListEnvironment(schoolApiClient: appEnvironment.schoolApiClient,
                                                           requestProvider: appEnvironment.requestProvider)
        let coordinator = SchoolListCoodinator.init(navigator: navigator,
                                                    environment: schoolEnvironment)
        
        coordinate(to: coordinator)
    }
}
