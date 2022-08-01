//
//  ServerResult.swift
//  BookMyMovie
//
//  Created by Parampal Singh on 30/07/22.
//

import Foundation

enum ServerResponse<T> {
    //typealias JSON = [String:Any]
    case success(T)
    case failure(ServerError)
}
