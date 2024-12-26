//
//  VaccineHistory.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 08/12/24.
//

import Foundation

class vaccine_history: Identifiable, Hashable, Equatable {
    
    let vaccine_history_id: UUID
    let vaccine_history_details: [vaccine_history_details]
    
    init(vaccine_history_id: UUID, vaccine_history_details: [vaccine_history_details]) {
        self.vaccine_history_id = vaccine_history_id
        self.vaccine_history_details = vaccine_history_details
    }


    static func == (lhs: vaccine_history, rhs: vaccine_history) -> Bool {
        return lhs.vaccine_history_id == rhs.vaccine_history_id &&
               lhs.vaccine_history_details == rhs.vaccine_history_details
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(vaccine_history_id)
        hasher.combine(vaccine_history_details)
    }
}
