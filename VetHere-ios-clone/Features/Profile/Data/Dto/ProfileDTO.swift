//
//  PetDto.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

struct GetProfileResponseDto : Decodable{
    let username : String
    let first_name : String
    let last_name : String?
    let image : String?
}

struct GetProfileRequestDto: Codable{
}

struct UpdateProfileResponseDto : Decodable{
}

struct UpdateProfileRequestDto: Encodable{
    let first_name : String?
    let last_name : String?
    let image : Data?
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        if let first_name = first_name {
            dict["first_name"] = first_name
        }
        if let last_name = last_name {
            dict["last_name"] = last_name
        }
        if let image = image {
            dict["image"] = image
        }
        return dict
    }
    
}


struct UpdateProfileResponseDto : Decodable{

}

struct UpdateProfileRequestDto: Codable{
    let first_name : String?
    let last_name : String?
    let image : Data?
    
}

