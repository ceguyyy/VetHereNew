//
//  PetService.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

internal struct UpdatePetService {
    
    static func UpdateNewPet(
        params: UpdatePetRequestDTO,
        file: NetworkManager.File
    ) -> APIService {
        let path = "/pet/update"
        return APIService(
            method: .POST,
            path: path,
            headers: nil,
            params: params.toDictionary(),
            parameterEncoding: .multiformdata,
            file: file
        )
    }
}


