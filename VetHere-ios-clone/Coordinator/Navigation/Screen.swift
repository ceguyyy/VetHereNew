//
//  Screen.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

enum Screen: Identifiable, Hashable, Equatable{
    case splash
    case login
    case profile
    case nearestVet
    case register
    case history
    case contentView
    case myPet
    case myPetDetail(petId: UUID)
    case details(vetId: UUID, vetDistance: Double)
    case bookChoosePet(vetId: UUID, vetName: String, doctorId: UUID, DoctorName: String)
    case bookChooseSchedule(vetId: UUID, vetName: String, doctorId: UUID, DoctorName: String, petId: UUID, PetName: String)
    case bookNotes(vetId: UUID, vetName: String, doctorId: UUID, DoctorName: String, petId: UUID, PetName: String, Date: Date, Time: Date)
    case summary(vetId: UUID, vetName: String, doctorId: UUID, DoctorName: String, petId: UUID, PetName: String, Date: Date, Time: Date, Notes: String)
    case successToDatabase
    case errorToDatabase
    case medicalRecord(vetName: String, doctorName: String,petName: String, medical_records: medical_records)
    case vaccineHistory(vetName: String, doctorName: String, petName: String, vaccine: vaccine_history)
    case historyDetailView(date: Date, time: String, vetName: String, doctorName: String, PetName: String, notes: String)
    
  
//    case contentView
    var id: Self { return self }
}
