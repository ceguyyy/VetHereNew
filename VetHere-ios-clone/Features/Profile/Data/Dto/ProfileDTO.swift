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

