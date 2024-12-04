//
//  AuthenticationService.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

internal struct AuthenticationService {
    static func login(
        params: LoginRequestDto
    ) -> APIService {
        let path = "/auth/login"
        
        return APIService(
            method: .POST,
            path: path,
            headers: nil,
            params: params.toDictionary(),
            parameterEncoding: .json
        )
    }
    
    static func register(
        params: RegisterRequestDTO
    ) -> APIService {
        let path = "/auth/register"
        
        return APIService(
            method: .POST,
            path: path,
            headers: nil,
            params: params.toDictionary(),
            parameterEncoding: .json
        )
    }
    
//    static func validateUsername(
//        params: ValidateUsernameRequestDTO
//    ) -> APIService {
//        let path = "/user/check-username"
//        
//        return APIService(
//            method: .POST,
//            path: path,
//            headers: nil,
//            params: params.toDictionary(),
//            parameterEncoding: .json
//        )
//    }
}
