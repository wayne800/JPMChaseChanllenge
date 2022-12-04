//
//  BaseViewController.swift
//  JMPChaseChallenge
//
//  Created by Yangbin Wen on 12/3/22.
//

import UIKit

class BaseViewController: UIViewController {

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .medium)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("[ViewController] 🟢 \(String(describing: self)) -> start")
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
    }
    
    func shouldDisplayIndicator(display: Bool) {
        if display {
            view.bringSubviewToFront(loadingIndicator)
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
        }
    }
    
    deinit {
        print("[ViewController] 💥 \(String(describing: self)) -> deinit")
    }
}
