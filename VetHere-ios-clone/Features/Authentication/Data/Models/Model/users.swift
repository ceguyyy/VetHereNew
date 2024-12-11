//
//  User.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

class users{
    let user_id: UUID
    let username: String
    let first_name: String
    let last_name: String
    let password: String
    let role: String
    let createdAt: Date
    let updatedAt: Date
    let imageName: String
    
    init(userID: UUID, username: String, firstName: String, lastName: String, password: String, role: String, createdAt: Date, updatedAt: Date, imageName: String) {
        self.user_id = userID
        self.username = username
        self.first_name = firstName
        self.last_name = lastName
        self.password = password
        self.role = role
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.imageName = imageName
    }
}
