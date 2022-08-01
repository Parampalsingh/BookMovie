//
//  AppFont.swift
//  BookMovie
//
//  Created by Parampal Singh on 01/08/22.
//

import Foundation
import UIKit

// App Font
enum Poppins: String {
    
    case regular
    case semiBold
    case medium
    case bold
    case light
    
    func ofSize(_ size: CGFloat) -> UIFont? {
        let font = UIFont(name: name(), size: size)
        return font
    }
    
    func name() -> String {
        return "Poppins-" + rawValue.capitalized
    }
}
