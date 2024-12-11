//
//  Specialization.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import Foundation
class specialization{
    let specialization_id: UUID
    let specialization_name: String
    let created_at: Date
    let updated_at: Date
    
    
    init(speclization_id: UUID, speclization_name: String, created_at: Date, updated_at: Date) {
        self.specialization_id = speclization_id
        self.specialization_name = speclization_name
        self.created_at = created_at
        self.updated_at = updated_at
    }
}
