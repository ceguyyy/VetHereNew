//
//  Screen.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation

enum Screen: Identifiable, Hashable{
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
    case medicalRecord(date: String, vetName: String, doctorName: String, diagnose: String, action: String, petName: String)
    case vaccineHistory(date: String, vetName: String, doctorName: String, vaccineName: String, petName: String)
    
  
//    case contentView
    var id: Self { return self }
}
