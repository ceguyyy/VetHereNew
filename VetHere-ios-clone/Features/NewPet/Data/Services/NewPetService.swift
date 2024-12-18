//
//  PetService.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

internal struct NewPetService {
    
    static func addNewPet(
        params: NewPetRequestDTO,
        file: NetworkManager.File
    ) -> APIService {
        let path = "/pet/create"
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
