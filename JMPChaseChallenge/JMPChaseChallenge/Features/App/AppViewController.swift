//
//  ViewController.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import UIKit

class AppViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        coordinator?.coordinateToMain()
    }
}

