//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//


import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel

    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: NoteViewModel(coordinator))
        
        
    }
    
    var body: some View {
        VStack {
            Text("Profile")
        }
        
        .navigationTitle("Masukkan Catatan")
        .navigationBarTitleDisplayMode(.inline)
      
    }
}

//#Preview {
//    @Previewable
//    @StateObject var appCoordinator = AppCoordinator()
//    NavigationStack(path: $appCoordinator.path) {
//        NoteView(appCoordinator)
//            .navigationDestination(for: Screen.self) { screen in
//                appCoordinator.build(screen)
//            }
//    }
//}
