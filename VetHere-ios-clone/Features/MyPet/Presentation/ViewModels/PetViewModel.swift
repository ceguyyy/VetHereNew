//
//  MyPetViewModel.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation
import SwiftUICore

class PetViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let authenticationDefault = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol
    
    @Published var pets: [Pet] = []
    
    enum InputGesture{
        case DidChoosePet
    }
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func GetUserPets(){
        pets.removeAll()
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            let service = PetService.getUserPets()
            
            let request = await networkManager.makeRequest(service, output: [GetUserPetsResponseDto].self)
            
            switch request {
            case .success(let response):
                if response.meta.success, let data = response.data {
                    self.pets = data.map { pet in
                        Pet(
                            petId: pet.pet_id,
                            petName: pet.pet_name,
                            petType: pet.pet_type ?? "unknown",
                            petImage: pet.pet_image ?? ""
                        )
                    }
                    
                } else {
                    print("Failed to fetch pets: \(response.meta.message)")
                }
                
            case .failure(let error):
                print("Error fetching pets: \(error)")
            }
        }
    }
}
