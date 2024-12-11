//
//  Doctor.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import Foundation

class doctors{
    let doctor_id: UUID
    let doctor_name: String
    let doctor_rating: Int
    let specialization: specialization
    let doctor_image: String?
    
    
    init(doctor_id: UUID, doctor_name: String, doctor_rating: Int, specialization: specialization, doctor_image: String?) {
        self.doctor_id = doctor_id
        self.doctor_name = doctor_name
        self.doctor_rating = doctor_rating
        self.specialization = specialization
        self.doctor_image = doctor_image
    }
}
