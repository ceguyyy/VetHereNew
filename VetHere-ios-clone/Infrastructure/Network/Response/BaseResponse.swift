//
//  BaseResponse.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation


struct BaseResponse<T: Codable>: Codable {
    public let meta: Meta
    public let data: T?
}

struct Meta: Codable {
    public let success: Bool
    public let message: String
    public let error: String?
}

extension Error {
    func toResponseError() -> NetworkError {
        if let responseError = self as? NetworkError {
            return responseError
        } else {
            return .genericError(error: self)
        }
    }
}
