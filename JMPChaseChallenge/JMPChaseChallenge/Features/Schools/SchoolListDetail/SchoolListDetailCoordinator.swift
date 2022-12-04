//
//  SchoolListDetailCoordinator.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import SwiftUI

final class SchoolListDetailCoordinator: UICoordinator {
    private let environment: SchoolListDetailEnvironment
    private let navigaotr: NavigatorType
    
    init(environment: SchoolListDetailEnvironment, navigaotr: NavigatorType) {
        self.environment = environment
        self.navigaotr = navigaotr
    }
    
    func start() {
        let viewModel = SchoolListDetailViewModel(schoolModel: environment.schoolModel)
        let view = SchoolListDetailView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        
        navigaotr.push(controller, animated: true) {[weak self] in
            self?.finish()
        }
    }
}
