//
//  SchoolListCoordinator.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import Foundation
import UIKit

protocol SchoolListCoodinatorInput {
    func coordinateToDetail(with item: SchoolListDetailModel)
    func coordinateToAlert(with info: String)
}

protocol SchoolListCoodinatorType: AnyObject, SchoolListCoodinatorInput {
    var input: SchoolListCoodinatorInput { get }
}

final class SchoolListCoodinator: UICoordinator, SchoolListCoodinatorInput {
    // MARK: properties
    
    private let navigator: NavigatorType
    private let environment: SchoolListEnvironment
    
    // MARK: Initialization
    
    init(navigator: NavigatorType, environment: SchoolListEnvironment) {
        self.navigator = navigator
        self.environment = environment
    }
    
    func start() {
        let viewController = SchoolListViewController()
        let viewModel = SchoolListViewModel(schoolsApiClient: environment.schoolApiClient,
                                            requestProvider: environment.requestProvider)
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        // This could be a simulation as the completion of other flow, such as user signIn.
        // Replace root module from AppViewController to SchoolListViewController since it's the main viewController of this app.
        navigator.setRootModule(viewController, animated: true, completion: nil)
    }
    
    // MARK: SchoolListCoodinatorInput
    func coordinateToDetail(with item: SchoolListDetailModel) {
        let environment = SchoolListDetailEnvironment(schoolModel: item)
        let coordinator = SchoolListDetailCoordinator(environment: environment, navigaotr: navigator)
        
        coordinate(to: coordinator)
    }
    
    func coordinateToAlert(with info: String) {
        let alert = UIAlertController(title: "Error Occurs. Pull Down to refresh.",
                                      message: info,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        navigator.toPresent().present(alert, animated: true)
    }
}

extension SchoolListCoodinator: SchoolListCoodinatorType {
    var input: SchoolListCoodinatorInput { self }
}

