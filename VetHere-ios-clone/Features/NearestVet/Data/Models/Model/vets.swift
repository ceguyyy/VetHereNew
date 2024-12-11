//
//  User.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

class vets{
    let vet_id: UUID
    let vet_name: String
    let vet_description: String
    let vet_rating: Int
    let vet_openHour: Double
    let vet_closeHour: Double
    let vet_image: String
    let vet_range: Double
    let vet_address: String
    let createdAt: Date
    let updatedAt: Date
    let vet_distance: Double
    
    init(vet_id: UUID, vet_name: String, vet_description: String, vet_rating: Int, vet_openHour: Double, vet_closeHour: Double, vet_image: String, vet_range: Double, vet_address: String, createdAt: Date, updatedAt: Date, vet_distance: Double) {
        self.vet_id = vet_id
        self.vet_name = vet_name
        self.vet_description = vet_description
        self.vet_rating = vet_rating
        self.vet_openHour = vet_openHour
        self.vet_closeHour = vet_closeHour
        self.vet_image = vet_image
        self.vet_range = vet_range
        self.vet_address = vet_address
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.vet_distance = vet_distance
    }
    
}
    
