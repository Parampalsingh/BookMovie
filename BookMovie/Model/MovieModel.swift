//
//  MovieModel.swift
//  BookMovie
//
//  Created by Parampal Singh on 31/07/22.
//

import Foundation

struct MovieModel: Codable {
    
    var results: [MovieList]
    
}

struct MovieList: Codable {
    
    var id: Int
    var poster_path: String
    var original_title: String
    var overview: String
    
}
