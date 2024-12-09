//
//  MedicalRecordDetail.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation

class MedicalRecordDetail: Identifiable {
    let medicalRecordId : String
    let vetName : String
    let diagnosis : String
    let treatment : String
    let date : String
    
    init(medicalRecordId: String, vetName: String, diagnosis: String, treatment: String, date: String) {
        self.medicalRecordId = medicalRecordId
        self.vetName = vetName
        self.diagnosis = diagnosis
        self.treatment = treatment
        self.date = date
    }
}
