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
        case .register:
            RegisterView(self)
        case .nearestVet:
            NearestVetView()
        case .details:
            DetailsView()
        case .history:
            HistoryView()
        case .contentView:
            ContentView()
        case .myPet:
            MyPetView()
        }
        
    }
}
