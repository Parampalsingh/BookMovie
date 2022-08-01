//
//  BaseTabbarController.swift
//  BookMovie
//
//  Created by Parampal Singh on 31/07/22.
//

import UIKit

class BaseTabbarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        applyStyle()
        delegate = self
    }
    
    deinit {
        print("deinit")
    }
    
    
    private func applyStyle() {
        let selectedAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)]
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        let unselectedAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)]
        UITabBarItem.appearance().setTitleTextAttributes(unselectedAttributes, for: .normal)
        self.tabBar.tintColor  =    UIColor.white
        self.tabBar.barTintColor = UIColor(red: 46/255.0, green: 39/255.0, blue: 57/255.0, alpha: 1.0)
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.clipsToBounds = true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        UIView.transition(with: view, duration: 0.35, options: .transitionCrossDissolve, animations: nil)
    }
}
