//
//  Pet.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

class Pet{
    let id : UUID
    let name : String
    let type : String
    let image : String
    let weight : Double
    let DOB : String
    let breed : String
    let color : String
//    let medicalRecord : MedicalRecord?
//    let vaccineHistory : [VaccineHistory]
    
    init(id: UUID, name: String, type: String, image: String, weight: Double, DOB: String, breed: String, color: String) {
        self.id = id
        self.name = name
        self.type = type
        self.image = image
        self.weight = weight
        self.DOB = DOB
        self.breed = breed
        self.color = color
    }
}
