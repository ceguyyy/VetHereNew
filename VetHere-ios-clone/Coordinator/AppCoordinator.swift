//
//  AppCoordinator.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import Foundation
import SwiftUI

class AppCoordinator: AppCoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    @Published var currentTab: ApplicationTab = .Clinic
    
    func push(_ screen: Screen) {
        print("Navigating to screen: \(screen)")
        path.append(screen)
    }


    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func pop(_ count: Int) {
        guard count > 0, count <= path.count else { return }
        path.removeLast(count)
    }

    func popToRoot() {
        guard !path.isEmpty else { return }
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
    }
    
    func dismissFullScreenOver() {
    }
    

    
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .splash:
            SplashView(self)
        case .login:
            LoginView(self)
        case .profile:
            ProfileView(self)
        case .nearestVet:
            NearestVetsView(self)
        case .details(let vetId, let vetDistance):
            VetDetailsView(self, vetId: vetId, vetDistance: vetDistance)
        case .history:
            HistoryView()
        case .contentView:
            ContentView(self)
        case .myPet:
            MyPetView(self)
        case .myPetDetail(let petId):
            MyPetDetailView(self, petId: petId)
        case .register:
            RegisterView(self)
        case .bookChoosePet(let vetId, let vetName, let doctorId, let doctorName):
            BookChoosePetView(self, vetId: vetId, vetName: vetName, doctorId: doctorId, doctorName: doctorName)
        case .bookChooseSchedule(let vetId, let vetName, let doctorId, let doctorName, let PetId, let PetName):
            BookChooseScheduleView(self, vetId: vetId, vetName: vetName, doctorId: doctorId, doctorName: doctorName, petId: PetId, petName: PetName)
        case .bookNotes(let vetId, let vetName, let doctorId, let doctorName, let PetId, let PetName, let date, let time):
            NoteView(self, vetId: vetId, vetName: vetName, doctorId: doctorId, doctorName: doctorName, petId: PetId, petName: PetName, date: date, time: time)
        case .summary(let vetId, let vetName, let doctorId, let doctorName, let PetId, let PetName, let date, let time, let notes):
            SummaryView(self, vetId: vetId, vetName: vetName, doctorId: doctorId, doctorName: doctorName, petId: PetId, petName: PetName, date: date, time: time, notes: notes)
        case .successToDatabase:
            SuccessBookView(self)
        case .errorToDatabase:
            FailedBookView(self)
        }
        
    }

}
