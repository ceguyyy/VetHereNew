//
//  Pet.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

class pet{
    let pet_id: UUID
    let pet_type: String
    let pet_breed: String
    let pet_image: String
    let pet_name: String
    let pet_color: String
    let pet_dob: String
    let pet_weight: Int
    let medical_record: [medical_records]?
    let vaccine_histories: [vaccine_history]?
    
    init(pet_id: UUID, pet_type: String, pet_breed: String, pet_image: String, pet_name: String, pet_color: String, pet_dob: String, pet_weight: Int, medical_record: [medical_records]?, vaccine_histories: [vaccine_history]?) {
        self.pet_id = pet_id
        self.pet_type = pet_type
        self.pet_breed = pet_breed
        self.pet_image = pet_image
        self.pet_name = pet_name
        self.pet_color = pet_color
        self.pet_dob = pet_dob
        self.pet_weight = pet_weight
        self.medical_record = medical_record
        self.vaccine_histories = vaccine_histories
    }
}
