//
//  MyPetViewModel.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation
import SwiftUICore

class MyPetViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol

    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var loadingState: LoadingState = .loading
    
    @Published var pets: [GetUserPetsResponseDto] = []
    
    
    
    enum goAction {
        case goToSchedule(vetid: UUID, vetName: String, doctorId: UUID, DoctorName: String, petId: UUID, petName: String)
        case goToProfile
        case goToPetDetails(petId: UUID)
            }
    
    
    enum InputGesture{
        case didFetchMyPet

    }

    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func goToSchedule(_ goAction: goAction){
        switch goAction{
        case .goToSchedule(let vetId, let vetName, let doctorId, let doctorName, let petId, let petName):
            coordinator.push(.bookChooseSchedule(vetId: vetId, vetName: vetName, doctorId: doctorId, DoctorName: doctorName, petId: petId, PetName: petName))
            print("GoToDetails")
        case .goToProfile:
            coordinator.push(.profile)
        case .goToPetDetails(let petId):
            coordinator.push(.myPetDetail(petId: petId))
        }
    }
    
    func onInput(_ inputGesture:InputGesture){
        switch inputGesture{
        case .didFetchMyPet:
            getUserPets()
       
        }
        
    }
    
    func transformDTOtoPet() -> [Pet]{
        return pets.map {
            dto in
            Pet(id: UUID(uuidString: dto.pet_id) ?? UUID(),
                name: dto.pet_name,
                type: dto.pet_type ?? "Unknown",
                image: dto.pet_image ?? Constant.ErrorImage,
                weight: 0, DOB: "",
                breed: "",
                color: "")
        }
    }
    
    func getUserPets() {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            self.isLoading = true
            self.errorMessage = nil
            
            let dto = GetUserPetsRequestDto()
            let service = MyPetService.getMyPet(params: dto)
            
            let result = await networkManager.makeRequest(service, output: [GetUserPetsResponseDto].self)
            
            switch result {
            case .success(let response):
                if let petsData = response.data {
                    self.pets = petsData
                    print("Successfully fetched pets")
                } else {
                    self.errorMessage = "No pets data found."
                    print("No data available for pets.")
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
    
