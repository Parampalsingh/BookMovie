//
//  WebPath.swift
//  BookMyMovie
//
//  Created by Parampal Singh on 30/07/22.
//

import Foundation

enum WebPath: String {
    
    static let KBASE_URL = "https://api.themoviedb.org/3/movie/"
    static let KBASEIMAGE_URL = "https://image.tmdb.org/t/p/original"
    
    case movieList = "upcoming"
    
    
    
    var path: String {
        return WebPath.KBASE_URL + rawValue
    }
}
