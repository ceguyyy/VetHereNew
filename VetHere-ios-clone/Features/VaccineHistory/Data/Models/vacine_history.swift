//
//  VaccineHistory.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation

class vaccine_history: Identifiable, Hashable, Equatable {
    static func == (lhs: vaccine_history, rhs: vaccine_history) -> Bool {
        return lhs.id == rhs.id &&
               lhs.vaccineName == rhs.vaccineName &&
               lhs.vetName == rhs.vetName &&
               lhs.vaccineDate == rhs.vaccineDate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(vaccineName)
        hasher.combine(vetName)
        hasher.combine(vaccineDate)
    }
    
    let id: UUID
    let vaccineName: String
    let vetName: String
    let vaccineDate: String
    
    init(vaccineId: UUID, vaccineName: String, vetName: String, vaccineDate: String) {
        self.id = vaccineId
        self.vaccineName = vaccineName
        self.vetName = vetName
        self.vaccineDate = vaccineDate
    }
}
