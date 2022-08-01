//
//  Storyboards.swift
//  BookMovie
//
//  Created by Parampal Singh on 01/08/22.
//

import UIKit

enum Storyboard: String {
    
    case tabbar = "Tabbar"
    case dashborad = "Dashborad"
    case watch = "Watch"
    case more = "More"
    case mediaLibrary = "MediaLibrary"
}

extension UIViewController {
    
    class func initiateFromStoryboard(_ storyboard: Storyboard) -> Self {
        let story  = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let controller = story.instantiateViewController(identifier: "\(Self.self)") as? Self else {
            fatalError("Controller doesn't exist in \(storyboard.rawValue)")
        }
        return controller
    }
    
    func initiateFromStoryboard(_ storyboard: Storyboard) -> Self {
        let story  = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let controller = story.instantiateViewController(identifier: "\(Self.self)") as? Self else {
            fatalError("Controller doesn't exist in \(storyboard.rawValue)")
        }
        return controller
    }
}
