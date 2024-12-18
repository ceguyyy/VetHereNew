//
//  User.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

class vet_detail{
    let vet_detail_id: UUID
    let vet_name: String
    let vet_description: String
    let vet_rating: Int
    let vet_openHour: String
    let vet_closeHour: String
    let vet_image: String
    let vet_phone_number: String
    let vet_lattitude: Double
    let vet_longitude: Double
    let createdAt: Date
    let updatedAt: Date
    let vet_doctors: [doctors]?
    let facilities: [facilities]?
    
    init(id: UUID, name: String, description: String, rating: Int, openHour: String, closeHour: String, image: String, phoneNumber: String, lattitude: Double, longitude: Double, createdAt: Date, updatedAt: Date, doctor: [doctors]?, facilities: [facilities]?) {
        self.vet_detail_id = id
        self.vet_name = name
        self.vet_description = description
        self.vet_rating = rating
        self.vet_openHour = openHour
        self.vet_closeHour = closeHour
        self.vet_image = image
        self.vet_phone_number = phoneNumber
        self.vet_lattitude = lattitude
        self.vet_longitude = longitude
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.vet_doctors = doctor
        self.facilities = facilities
    }
    
}
