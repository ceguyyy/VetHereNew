//
//  HistoryModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 10/12/24.
//

import SwiftUI

class appoinments{
    let appointment_id: UUID
    let vet_name: String
    let doctor_name: String
    let pet_name: String
    let appointment_notes: String
    let appointment_date: Date
    let appointment_time: String
    
    init(appointment_id: UUID, vet_name: String, doctor_name: String, pet_name: String, appointment_notes: String, appointment_date: Date, appointment_time: String) {
        self.appointment_id = appointment_id
        self.vet_name = vet_name
        self.doctor_name = doctor_name
        self.pet_name = pet_name
        self.appointment_notes = appointment_notes
        self.appointment_date = appointment_date
        self.appointment_time = appointment_time
    }
}
