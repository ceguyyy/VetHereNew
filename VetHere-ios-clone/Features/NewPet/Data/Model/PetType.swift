//
//  PetType.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 03/01/25.
//

import Foundation

class PetType:Encodable{
    var id: String
    var name:String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
