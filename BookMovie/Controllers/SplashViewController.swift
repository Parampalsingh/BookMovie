//
//  NewSplashViewController.swift
//  BookMovie
//
//  Created by Parampal Singh on 31/07/22.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
    }

    deinit{
        print("dealloc \(Self.self)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppNavigator.shared.setRoot(.tabbar)
    }
}


