//
//  NearestVetViewModel.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 03/12/24.
//

import CoreLocation
import Foundation

class NearestVetViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol
    let locationManager = LocationManager()
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
        locationManager.requestLocationPermission()
        fetchNearestVets()
    }
    
    @Published var vet: [NearestResponseDTO] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    enum InputGesture {
        case didFetchNearestVet
    }
    
    enum goToDetailsGesture {
        case goToDetails(vetId: UUID, vetDistance:Double)
        case goToProfile
    }
    
    func goToDetails(_ goToDetailsGesture: goToDetailsGesture) {
        switch goToDetailsGesture {
        case .goToDetails(let vetId, let vetDistance):
            coordinator.push(.details(vetId: vetId, vetDistance: vetDistance))
        case .goToProfile:
            coordinator.push(.profile)
        }
    }
    
    func transformDTOToVets() -> [Vet] {
        return vet.map { dto in
            Vet(
                id: UUID(uuidString: dto.vet.vet_id) ?? UUID(),
                name: dto.vet.vet_name,
                description: dto.vet.vet_description,
                rating: dto.vet.vet_rating,
                openHour: Double(dto.vet.vet_open_hour) ?? 0.0,
                closeHour: Double(dto.vet.vet_close_hour) ?? 0.0,
                image: dto.vet.vet_image,
                range: dto.vet_distance,
                address: "",
                createdAt: Date(),
                updatedAt: Date(),
                distance: dto.vet_distance
            )
        }
    }
    
    struct ValidationResult {
        var isValid: Bool
        var message: String
    }
    
    var filteredVets: [Vet] {
        let allVets = transformDTOToVets()
        if searchText.isEmpty {
            return allVets
        } else {
            return allVets.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func onInput(_ inputGesture: InputGesture) {
        switch inputGesture {
        case .didFetchNearestVet:
            fetchNearestVets()
        }
    }
        
        func fetchNearestVets() {
            Task { @MainActor [weak self] in
                guard let self = self,
                      let latitude = self.locationManager.latitude,
                      let longitude = self.locationManager.longitude
                else { return }
                print("Location user: \(latitude), \(longitude)")
                self.isLoading = true
                self.errorMessage = nil
                let dto = NearestRequestDto(lattitude: latitude, longitude: longitude)
                let service = VetService.NearestVet(params: dto)
                let result = await networkManager.makeRequest(service, output: [NearestResponseDTO].self)
                switch result {
                case .success(let response):
                    if let vets = response.data {
                        vet = vets
                        print("Successfully fetched veterinarians: \(vets)")
                    } else {
                        self.errorMessage = "No veterinarians found in your area."
                        print("No data available")
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Failed to fetch veterinarians: \(error)")
                }
                
                self.isLoading = false
            }
        }

        
    }

