//
//  User.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

class Vet{
    let id: UUID
    let name: String
    let description: String
    let rating: Int
    let openHour: Double
    let closeHour: Double
    let image: String
    let range: Double
    let address: String
    let createdAt: Date
    let updatedAt: Date
    let distance: Double
    
    init(id: UUID, name: String, description: String, rating: Int, openHour: Double, closeHour: Double, image: String, range: Double, address: String, createdAt: Date, updatedAt: Date, distance: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.rating = rating
        self.openHour = openHour
        self.closeHour = closeHour
        self.image = image
        self.range = range
        self.address = address
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.distance = distance
    }
    
}
    
