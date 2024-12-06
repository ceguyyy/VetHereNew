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
        case .register:
            RegisterView(self)
        case .bookChoosePet(let vetId, let vetName, let doctorId, let doctorName):
            BookChoosePet(self, vetId: vetId, vetName: vetName, doctorId: doctorId, doctorName: doctorName)
        }
        
    }

}
