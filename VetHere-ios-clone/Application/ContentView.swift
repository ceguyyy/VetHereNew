//
//  ContentView.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel

    @State private var selectedTab: ApplicationTab = .Clinic
    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(
            wrappedValue: ContentViewModel(coordinator)
        )
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            NearestVetsView(viewModel.coordinator)
                .tabItem {
                    Label("Klinik", systemImage: "house")
                }
                .tag(ApplicationTab.Clinic)
            MyPetView(viewModel.coordinator)
                .tabItem {
                    Label("Peliharaan", systemImage: "pawprint.fill")
                }
                .tag(ApplicationTab.MyPets)
            HistoryView()
                .tabItem {
                    Label("Riwayat", systemImage: "clock")
                }
                .tag(Screen.history)
        }
        .navigationBarBackButtonHidden()
    }
}



#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path){
        ContentView(AppCoordinator())
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
    
