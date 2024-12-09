//
//  User.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

class VetDetail{
    let id: UUID
    let name: String
    let description: String
    let rating: Int
    let openHour: String
    let closeHour: String
    let image: String
    let phoneNumber: String
    let lattitude: Double
    let longitude: Double
    let createdAt: Date
    let updatedAt: Date
    let doctor: [DoctorModel]?
    let facilities: [FacilitiesModel]?
    
    init(id: UUID, name: String, description: String, rating: Int, openHour: String, closeHour: String, image: String, phoneNumber: String, lattitude: Double, longitude: Double, createdAt: Date, updatedAt: Date, doctor: [DoctorModel]?, facilities: [FacilitiesModel]?) {
        self.id = id
        self.name = name
        self.description = description
        self.rating = rating
        self.openHour = openHour
        self.closeHour = closeHour
        self.image = image
        self.phoneNumber = phoneNumber
        self.lattitude = lattitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.doctor = doctor
        self.facilities = facilities
    }
    
}
