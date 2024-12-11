//
//  Facilities.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//
import Foundation

class facilities{
    let facilities_id: UUID
    let name: String
    let updatedAt: Date
    let createdAt: Date
    
    init (facilities_id: UUID, name: String, updatedAt: Date, createdAt: Date){
        self.facilities_id = facilities_id
        self.name = name
        self.updatedAt = updatedAt
        self.createdAt = createdAt
    }
}
