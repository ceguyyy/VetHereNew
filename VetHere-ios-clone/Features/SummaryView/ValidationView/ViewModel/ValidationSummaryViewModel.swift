//
//  DetailsViewModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import Foundation

class validationSummaryViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var loadingState: LoadingState = .loading
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    
    enum goAction {
        case goToSplah
        
    }
    
    func goToDetails(_ goAction: goAction) {
        switch goAction {
            
        case .goToSplah:
            coordinator.popToRoot()
            coordinator.push(.splash)
        }
    }
    
    struct ValidationResult {
        var isValid: Bool
        var message: String
    }
    
}
