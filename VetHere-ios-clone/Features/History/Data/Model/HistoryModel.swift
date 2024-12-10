//
//  HistoryModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 10/12/24.
//

import SwiftUI

class HistoryModel{
    let id: UUID
    let vetName: String
    let doctorName: String
    let petName: String
    let notes: String
    let date: Date
    let time: String
    
    init(id: UUID, vetName: String, doctorName: String, petName: String, notes: String, date: Date, time: String) {
        self.id = id
        self.vetName = vetName
        self.doctorName = doctorName
        self.petName = petName
        self.notes = notes
        self.date = date
        self.time = time
    }
}
