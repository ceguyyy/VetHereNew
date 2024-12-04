//
//  NetworkError.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

enum NetworkError: Error {
    case forbidden
    case invalidURL
    case invalidResponse
    case noData
    case invalidParameters
    case errorResponse(error: String?)
    case genericError(error: Error)

    var errorMessage: String {
        switch self {
        case .forbidden:
            return "You don't have permission to access this resource."
        case .errorResponse(let error):
            return error ?? "We couldn't connect to our data. Please retry again and make sure internet connection is good."
        default:
            return "We couldn't connect to our data. Please retry again and make sure internet connection is good."
        }
    }
}
