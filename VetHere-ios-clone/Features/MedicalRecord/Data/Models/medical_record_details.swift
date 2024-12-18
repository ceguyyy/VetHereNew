//
//  MedicalRecordDetail.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation

class medical_record_details: Identifiable, Hashable, Equatable {
    let medicalRecordId: UUID
    let vetName: String
    let diagnosis: String
    let treatment: String
    let createdAt: Date
    let updatedAt: Date
    
    init(medicalRecordId: UUID, vetName: String, diagnosis: String, treatment: String, createdAt: Date, updatedAt: Date) {
        self.medicalRecordId = medicalRecordId
        self.vetName = vetName
        self.diagnosis = diagnosis
        self.treatment = treatment
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    static func == (lhs: medical_record_details, rhs: medical_record_details) -> Bool {
        return lhs.medicalRecordId == rhs.medicalRecordId &&
               lhs.vetName == rhs.vetName &&
               lhs.diagnosis == rhs.diagnosis &&
               lhs.treatment == rhs.treatment &&
               lhs.createdAt == rhs.createdAt &&
               lhs.updatedAt == rhs.updatedAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(medicalRecordId)
        hasher.combine(vetName)
        hasher.combine(diagnosis)
        hasher.combine(treatment)
        hasher.combine(createdAt)
        hasher.combine(updatedAt)
    }
}
