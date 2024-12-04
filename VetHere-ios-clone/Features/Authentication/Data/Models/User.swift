//
//  User.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

class User{
    let userID: UUID
    let username: String
    let firstName: String
    let lastName: String
    let password: String
    let role: String
    let createdAt: Date
    let updatedAt: Date
    let imageName: String
    
    init(userID: UUID, username: String, firstName: String, lastName: String, password: String, role: String, createdAt: Date, updatedAt: Date, imageName: String) {
        self.userID = userID
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.role = role
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.imageName = imageName
    }
}
