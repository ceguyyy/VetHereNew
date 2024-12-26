//
//  PetService.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

internal struct ProfileService {
    static func getProfile(
        params: GetProfileRequestDto
    ) -> APIService {
        let path = "/user"
        return APIService(
            method: .GET,
            path: path,
            headers: nil,
            params: params.toDictionary(),
            parameterEncoding: .json
        )
    }
    
    static func updateProfile(
        params: UpdateProfileRequestDto,
        file: NetworkManager.File
    ) -> APIService {
        let path = "/user"
        return APIService(
            method: .PATCH,
            path: path,
            headers: nil,
            params: params.toDictionary(),
            parameterEncoding: .multiformdata,
            file: file
            
        )
    }
    
}


