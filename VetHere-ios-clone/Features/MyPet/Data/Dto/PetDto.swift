//
//  PetDto.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

struct GetUserPetsResponseDto : Codable{
    let pet_id : String
    let pet_name : String
    let pet_type : String?
    let pet_image : String?
}
