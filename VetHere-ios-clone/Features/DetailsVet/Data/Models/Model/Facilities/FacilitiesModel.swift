//
//  Facilities.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//
import Foundation

class FacilitiesModel{
    let id: UUID
    let name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
