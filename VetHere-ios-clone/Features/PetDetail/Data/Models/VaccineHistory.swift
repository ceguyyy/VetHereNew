//
//  VaccineHistory.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation
class VaccineHistory: Identifiable {
    let vaccineId : UUID
    let vaccineName : String
    let vetName : String
    let vaccineDate : String
    
    init(vaccineId: UUID, vaccineName: String, vetName: String, vaccineDate: String) {
        self.vaccineId = vaccineId
        self.vaccineName = vaccineName
        self.vetName = vetName
        self.vaccineDate = vaccineDate
    }
    
}
