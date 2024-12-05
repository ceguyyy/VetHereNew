//
//  NearestVetViewModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//



import Foundation

class ContentViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    let coordinator: any AppCoordinatorProtocol

    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

