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
    case nearestVet
    case register
    case history
    case contentView
    case myPet
    case myPetDetail(petId: String)
    case details(vetId: UUID, vetDistance: Double)
    case bookChoosePet(vetId: UUID, vetName: String, doctorId: UUID, DoctorName: String)
  
//    case contentView
    var id: Self { return self }
}
