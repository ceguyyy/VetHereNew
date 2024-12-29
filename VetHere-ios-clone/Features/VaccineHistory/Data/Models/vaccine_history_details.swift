//
//  MedicalRecordDetail.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation

class vaccine_history_details: Identifiable, Hashable, Equatable {
    let vaccine_history_detail_id: UUID
    let vet_name: String
    let vaccine_name: String
    let createdAt: Date
    let updatedAt: Date
    
    init(vaccine_history_detail_id: UUID, vet_name: String, vaccine_name: String, createdAt: Date, updatedAt: Date) {
        self.vaccine_history_detail_id = vaccine_history_detail_id
        self.vet_name = vet_name
        self.vaccine_name = vaccine_name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    static func == (lhs: vaccine_history_details, rhs: vaccine_history_details) -> Bool {
        return lhs.vaccine_history_detail_id == rhs.vaccine_history_detail_id &&
               lhs.vet_name == rhs.vet_name &&
               lhs.vaccine_name == rhs.vaccine_name &&
               lhs.createdAt == rhs.createdAt &&
               lhs.updatedAt == rhs.updatedAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(vaccine_history_detail_id)
        hasher.combine(vet_name)
        hasher.combine(vaccine_name)
        hasher.combine(createdAt)
        hasher.combine(updatedAt)
    }
}
