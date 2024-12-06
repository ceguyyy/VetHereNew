//
//  Doctor.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import Foundation

class Doctor{
    let id: UUID
    let name: String
    let rating: Int
    let specialization: Specialization
    let image: String?
    
    init (id: UUID, name: String, rating: Int, specialization: Specialization, image: String?){
        self.id = id
        self.name = name
        self.rating = rating
        self.specialization = specialization
        self.image = image
    }
}
