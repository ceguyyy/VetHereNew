//
//  PetRequestDTO.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 09/12/24.
//


import Foundation

struct NewPetRequestDTO: Encodable {
    var pet_type_Id: String
    var breed_id: String?
    var pet_image: Data
    var pet_name: String
    var pet_color: String?
    var pet_dob: String
    var pet_weight: String

    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "pet_type_Id": pet_type_Id,
            "pet_name": pet_name,
            "pet_dob": pet_dob,
            "pet_weight": pet_weight
        ]
        if let breedId = breed_id {
            dict["breed_id"] = breedId
        }
        if let petColor = pet_color {
            dict["pet_color"] = petColor
        }
        return dict
    }
}



struct AddNewPetResponseDTO:Codable{
}

