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
            HistoryView(self)
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
            BookInputNoteView(self, vetId: vetId, vetName: vetName, doctorId: doctorId, doctorName: doctorName, petId: PetId, petName: PetName, date: date, time: time)
        case .summary(let vetId, let vetName, let doctorId, let doctorName, let PetId, let PetName, let date, let time, let notes):
            BookSummaryView(self, vetId: vetId, vetName: vetName, doctorId: doctorId, doctorName: doctorName, petId: PetId, petName: PetName, date: date, time: time, notes: notes)
        case .successToDatabase:
            BookSuccessView(self)
        case .errorToDatabase:
            BookFailedView(self)
        case .medicalRecord(let vetName, let doctorName, let petName, let medical_records):
            MedicalRecordView(self, vetName: vetName, doctorName: doctorName, petName: petName, medicalRecord: medical_records)
       
        case .historyDetailView(let date, let time, let vetName, let doctorName, let petName, let notes):
            HistoryDetailView(self, date: date, time: time, vetName: vetName, doctorName: doctorName, petName: petName, notes: notes)
            
        case .vaccineHistory(vetName: let vetName, doctorName: let doctorName, petName: let petName, vaccine: let vaccine):
            VaccineHistoryView(self, vetName: vetName, doctorName: doctorName, petName: petName, vaccine: vaccine)
        }
    }

}
//vetName: String, doctorName: String, petName: String, vaccine: vaccine_history
//case .vaccineHistory(let vaccine, let vetName, let doctorName,let petName):
//    VaccineHistoryView(self, vetName: vetName, doctorName: doctorName, petName: petName, vaccine: vaccine)
