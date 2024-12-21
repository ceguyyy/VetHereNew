//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

//
//  ProfileView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    

    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(coordinator))
    }

    var body: some View {
        VStack(spacing: 20) {
           
            if viewModel.isLoading {
                VStack{
                    ProgressView()
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
                }
     
                
            } else {
                ImageView(imageURL: viewModel.user.image, width: 100, height: 100)
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 5)
                

                Text(viewModel.user.username)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(viewModel.user.first_name)
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
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.getProfile()
        }
        .padding()
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        ProfileView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
