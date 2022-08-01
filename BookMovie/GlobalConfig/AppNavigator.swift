//
//  AppNavigator.swift
//  BookMovie
//
//  Created by Parampal Singh on 31/07/22.
//

import Foundation
import UIKit


class RootNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .darkContent
    }
    
//    override var prefersStatusBarHidden: Bool {
//        return topViewController?.prefersStatusBarHidden ?? false
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}


class AppNavigator {
    
    static let shared = AppNavigator()
    lazy var rootNavigator: RootNavigationController = {
        let navigationController = RootNavigationController()
        navigationController.navigationBar.isHidden = true
        return navigationController
    }()
    
    let reachability: Reachability?
    
    private init() {
        print("****Initializing AppNavigator Instance****")
        reachability = try? Reachability()
        reachability?.whenReachable = { reachability in
            NotificationCenter.default.post(name: NSNotification.Name("NETWORK_REACHABILITY"), object: reachability)
//            guard let presentedController = self.rootNavigator.presentedViewController as? ReachabilityViewController else {
//                return
//            }
//            presentedController.dismiss()
        }
        reachability?.whenUnreachable = { reachability in
            NotificationCenter.default.post(name: NSNotification.Name("NETWORK_REACHABILITY"), object: reachability)
//            self.rootNavigator.showErrorAlert("Please check your internet connection", showRefreshButton: false)
        }
    }
    
    func setRoot(_ root: RootController) {
        rootNavigator.viewControllers = [ root.controller]
        UIApplication.shared.windows.first?.backgroundColor = .white
        UIApplication.shared.windows.first?.rootViewController =  rootNavigator
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.3, options: [.transitionCrossDissolve], animations: {}, completion: nil)
    }
    
    func navigateFromRoot(to controller: UIViewController, animated: Bool = true) {
        rootNavigator.pushViewController(controller, animated: animated)
    }

    
}

enum RootController {
    
    case tabbar
    case dashboard
    case watch
    case medialib
    case more
    
    var controller: UIViewController {
        switch self {
        case .tabbar:
            return BaseTabbarController.initiateFromStoryboard(.tabbar)
        case .dashboard:
            return DashBoardViewController.initiateFromStoryboard(.dashborad)
        case .watch:
            return WatchViewController.initiateFromStoryboard(.watch)
        case .medialib:
            return MediaLibViewController.initiateFromStoryboard(.mediaLibrary)
        case .more:
            return MoreViewController.initiateFromStoryboard(.more)
        }
    }
}

