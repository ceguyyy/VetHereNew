//
//  PetService.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

internal struct MyPetService {
    static func getMyPet(
        params: GetUserPetsRequestDto
    ) -> APIService {
        let path = "/pet/all"
        return APIService(
            method: .GET,
            path: path,
            headers: nil,
            params: params.toDictionary(),
            parameterEncoding: .json
        )
    }
    
    static func deleteMyPet(
        params: deletePetRequestDto
    ) -> APIService {
        let path = "/pet/delete"
        return APIService(
            method: .POST,
            path: path,
            headers: nil,
            params: params.toDictionary(),
            parameterEncoding: .json
        )
    }
}


