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
}




//internal struct PetService{
//    static func getUserPets() -> APIService{
//        let path = "/pet/all"
//        
//        return APIService(
//            method: .GET,
//            path: path,
//            headers: nil,
//            params: params.toDictionary(),
//            parameterEncoding: .json
//        )
//    }
    
//    static func getUserPetDetail(params: GetPetDetailRequestDto) -> APIService{
//        let path = "/pet"
//        
//        return APIService(
//            method: .POST,
//            path: path,
//            headers: nil,
//            params: params.toDictionary(),
//            parameterEncoding: .json
//        )
//    }
//}
