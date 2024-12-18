//
//  NoteViewModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol

    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var loadingState: LoadingState = .loading

    @Published var user = GetProfileResponseDto(username: "", first_name: "", last_name: nil, image: nil)
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func logout() {
        credentialManager.clearCredentials()
        coordinator.popToRoot()
        coordinator.push(.login)
    }
    

    func transformDTOtoProfile() -> users {
        return users(
            userID: UUID(),
            username: user.username,
            firstName: user.first_name,
            lastName: user.last_name ?? "",
            password: "Password",
            role: "User",
            createdAt: Date(),
            updatedAt: Date(),
            imageName: user.image ?? Constant.ErrorImage
        )
    }


    func getProfile() {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            self.isLoading = true
            self.errorMessage = nil
            

            let dto = GetProfileRequestDto()
            let service = ProfileService.getProfile(params: dto)
            

            let result = await networkManager.makeRequest(service, output: GetProfileResponseDto.self)
            
            switch result {
            case .success(let response):
                if let profileData = response.data {
                    self.user = profileData
                    print("Successfully fetched profile")
                } else {
                    self.errorMessage = "No data found."
                    print("No data available for this profile.")
                }
                
            case .failure(let error):
            
                switch error {
                case .forbidden:
                    self.errorMessage = "You do not have permission to access this data."
                    print("Error: Forbidden access")
                case .invalidURL:
                    self.errorMessage = "Invalid URL. Please contact support."
                    print("Error: Invalid URL")
                default:
                    self.errorMessage = error.localizedDescription
                    print("Error fetching pets: \(error)")
                }
            }
            
            self.isLoading = false 
        }
    }
}
