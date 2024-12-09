//
//  NoteViewModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

class BookInputNoteViewModel: ObservableObject{
    
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    enum goAction {
        case goToSummary(vetId: UUID, VetName: String, DoctorName : String,  DoctorId: UUID, PetId: UUID, PetName: String, appointmentDate: Date, appointmentTime: Date, notes: String)
    }
    
    func goToDetails(_ goAction: goAction) {
        switch goAction {
        case .goToSummary(vetId: let vetId, VetName: let VetName, DoctorName: let DoctorName, DoctorId: let DoctorId, PetId: let PetId, PetName: let PetName, appointmentDate: let appointmentDate, appointmentTime: let appointmentTime, notes: let notes):
            coordinator.push(.summary(vetId: vetId, vetName: VetName, doctorId: DoctorId, DoctorName: DoctorName, petId: PetId, PetName: PetName, Date: appointmentDate, Time: appointmentTime, Notes: notes))
        }
    }
    
    
}
