//
//  ServerError.swift
//  BookMyMovie
//
//  Created by Parampal Singh on 30/07/22.
//

import Foundation

enum ServerError: Error {
    
    case invalidUrl
    case serialization
    case noInternet
    case noResponse
    case other(String)
    case none
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl:
            return "Please check url connection"
        case .serialization:
            return "Invalid response.\nPlease try again later."
        case .noInternet:
            return "Please check your internet connection"
        case .noResponse:
            return "Oops something went wrong.\nPlease try again later."
        case .other(let message):
            return message
        case .none:
            return ""
        }
    }
    
    var message: String {
        switch self {
        case .invalidUrl:
            return "Please check url connection"
        case .serialization:
            return "Oops something went wrong.\nPlease try again later."
        case .noInternet:
            return "Please check your internet connection"
        case .noResponse:
            return "Oops something went wrong.\nPlease try again later."
        case .other(let message):
            return message
        case .none:
            return ""
        }
    }
}
