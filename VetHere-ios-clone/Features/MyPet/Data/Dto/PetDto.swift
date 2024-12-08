//
//  PetDto.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

struct GetUserPetsResponseDto : Decodable{
    let pet_id : String
    let pet_name : String
    let pet_type : String?
    let pet_image : String
}

struct GetUserPetsRequestDto: Codable{
    
}

struct GetPetDetailRequestDto : Codable{
    let pet_id : String
}

struct GetPetDetailResponseDto : Codable{
    let pet_id : String
    let pet_type : String?
    let pet_breed : String?
    let pet_image: String?
    let pet_weight : Double?
    let pet_name:String
    let pet_color:String?
    let pet_dob:String?
    let medical_record : MedicalHistorylResponseDto?
    let vaccine_histories : [VaccineHistorylResponseDto]?
}
