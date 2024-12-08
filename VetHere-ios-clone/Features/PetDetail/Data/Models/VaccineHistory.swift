//
//  VaccineHistory.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation
class VaccineHistory: Identifiable {
    let vaccineId : String
    let vaccineName : String
    let vetName : String
    let vaccineDate : String
    
    init(vaccineId: String, vaccineName: String, vetName: String, vaccineDate: String) {
        self.vaccineId = vaccineId
        self.vaccineName = vaccineName
        self.vetName = vetName
        self.vaccineDate = vaccineDate
    }
    
}
