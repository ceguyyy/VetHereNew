//
//  MedicalRecord.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//
import Foundation

class MedicalRecord : Identifiable{
    let medicalRecordId : String
    let medicalRecordDetails : [MedicalRecordDetail]
    
    init(medicalRecordId: String, medicalRecordDetails: [MedicalRecordDetail]) {
        self.medicalRecordId = medicalRecordId
        self.medicalRecordDetails = medicalRecordDetails
    }
}
