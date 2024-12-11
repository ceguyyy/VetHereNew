//
//  DetailsViewModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import Foundation

class VetDetailsViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol
    @Published var input: InputValue = InputValue()
    @Published var vetDetail: vet_detail?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var loadingState: LoadingState = .loading
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    struct InputValue {
        var vetId: String = ""
    }
    
    enum InputGesture {
        case didFetchDetailVet(vetid: UUID)
    }
    
    enum goAction {
        case goToBookChooseVet(vetId: UUID, VetName: String, DoctorName : String,  DoctorId: UUID)
        case openWhatApp(vetDoctorName: String, vetPhoneNumber: String)
    }
    
    func goToDetails(_ goAction: goAction) {
        switch goAction {
        case .goToBookChooseVet(let vetId, let vetName, let doctorName, let doctorId):
            coordinator.push(.bookChoosePet(vetId: vetId, vetName: vetName, doctorId: doctorId, DoctorName: doctorName))
            print("GoToDetails")
            
            
        case .openWhatApp(vetDoctorName: let vetDoctorName, vetPhoneNumber: let vetPhoneNumber):
            openWhatsApp(phoneNumber: vetPhoneNumber, message: "Hello, saya butuh konsultasi dengan \(vetDoctorName)")
        }
    }
    
    struct ValidationResult {
        var isValid: Bool
        var message: String
    }
    
    func onInput(_ inputGesture: InputGesture, vetId: UUID) {
        switch inputGesture {
        case .didFetchDetailVet:
            print("Success did fetch Detail Vet")
            fetchDetailVets(vetId: vetId)
        }
    }
    
    func fetchDetailVets(vetId: UUID) {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            self.isLoading = true
            self.errorMessage = nil
            let dto = vetDetailRequestDTO(vet_id: vetId.uuidString)
            let service = VetDetailService.getVetDetail(params: dto)
            let result = await networkManager.makeRequest(service, output: vetDetailResponseDTO.self)
            
            switch result {
            case .success(let response):
                if let vetDetailDTO = response.data {
                    self.vetDetail = vet_detail(
                        id: UUID(uuidString: vetDetailDTO.vet_id) ?? UUID(),
                        name: vetDetailDTO.vet_name,
                        description: vetDetailDTO.vet_description,
                        rating: vetDetailDTO.vet_rating,
                        openHour: vetDetailDTO.vet_open_hour,
                        closeHour: vetDetailDTO.vet_close_hour,
                        image: vetDetailDTO.vet_image,
                        phoneNumber: vetDetailDTO.vet_detail.vet_phone_number,
                        lattitude: vetDetailDTO.vet_detail.vet_latitude,
                        longitude: vetDetailDTO.vet_detail.vet_longitude,
                        createdAt: Date(),
                        updatedAt: Date(),
                        doctor: vetDetailDTO.vet_doctors?.map {
                            doctors(
                                doctor_id: UUID(uuidString: $0.doctor_id) ?? UUID(),
                                doctor_name: $0.doctor_name,
                                doctor_rating: $0.doctor_rating,
                                
                                specialization: specialization(
                                    speclization_id: UUID(uuidString: $0.specialization.specialization_id) ?? UUID(),
                                    speclization_name: $0.specialization.specialization_name,
                                    created_at: Date(),
                                    updated_at: Date()
                                ),
                                doctor_image: ""
                            )
                        } ?? [
                            doctors(
                                doctor_id: UUID(), doctor_name: "NoDoctor", doctor_rating: 0,
                                specialization: specialization(
                                    speclization_id: UUID(),
                                    speclization_name: "",
                                    created_at: Date(),
                                    updated_at: Date()
                                ), doctor_image: ""),
                           
                        ],
                        facilities: vetDetailDTO.vet_facilities?.map {
                            facilities(
                                facilities_id: UUID(uuidString: $0.facility_id) ?? UUID(),
                                name: $0.facility_name,
                                updatedAt: Date(),
                                createdAt: Date()
                            )
                        } ?? [facilities(facilities_id: UUID(), name: "NoFacilities",updatedAt: Date(),
                                         createdAt: Date())]
                    )
                    loadingState = .loaded
                    print("Successfully fetched veterinarians: \(vetDetailDTO)")
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
