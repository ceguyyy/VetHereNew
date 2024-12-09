//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//


import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    
    let userName = "Binus"
    let userBio = "Happy person"
    let userProfileImage = "https://thumb.viva.co.id/media/frontend/thumbs3/2023/03/12/640dcafc3d2ac-binus-university_1265_711.jpg"

    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(coordinator))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            ImageView(imageURL: userProfileImage, width: 100, height: 100)
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .shadow(radius: 5)
            
            Text(userName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            

            Text(userBio)
                .font(.body)
                .foregroundColor(.secondary)
                .padding([.leading, .trailing], 20)
                .multilineTextAlignment(.center)
            
          
            Button(action: {
                viewModel.logout()
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                    .background(Capsule().stroke(Color.red, lineWidth: 2))
            }
            .padding(.top, 30)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        ProfileView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
