//
//  MedicalRecord.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//
import Foundation

class medical_records: Identifiable, Hashable, Equatable {
    
    let medicalRecordId: UUID
    let medicalRecordDetails: [medical_record_details]
    
    init(medicalRecordId: UUID, medicalRecordDetails: [medical_record_details]) {
        self.medicalRecordId = medicalRecordId
        self.medicalRecordDetails = medicalRecordDetails
    }


    static func == (lhs: medical_records, rhs: medical_records) -> Bool {
        return lhs.medicalRecordId == rhs.medicalRecordId &&
               lhs.medicalRecordDetails == rhs.medicalRecordDetails
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(medicalRecordId)
        hasher.combine(medicalRecordDetails)
    }
}
