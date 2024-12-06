//
//  Pet.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation

class Pet : Identifiable{
    let petId : String
    let petName : String
    let petType : String
    let petImage : String
    
    init(petId: String, petName: String, petType: String, petImage: String) {
        self.petId = petId
        self.petName = petName
        self.petType = petType
        self.petImage = petImage
    }
}
