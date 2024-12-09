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
    @Published var vetDetail: VetDetail?
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
                    self.vetDetail = VetDetail(
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
                            DoctorModel(
                                id: UUID(uuidString: $0.doctor_id) ?? UUID(),
                                name: $0.doctor_name,
                                rating: $0.doctor_rating,
                                specialization: SpecializationModel(
                                    id: UUID(uuidString: $0.specialization.specialization_id) ?? UUID(),
                                    name: $0.specialization.specialization_name
                                ),
                                image: ""
                            )
                        } ?? [
                            DoctorModel(
                                id: UUID(), name: "NoDoctor", rating: 0,
                                specialization: SpecializationModel(id: UUID(), name: ""), image: "")
                        ],
                        facilities: vetDetailDTO.vet_facilities?.map {
                            FacilitiesModel(
                                id: UUID(uuidString: $0.facility_id) ?? UUID(),
                                name: $0.facility_name
                            )
                        } ?? [FacilitiesModel(id: UUID(), name: "NoFacilities")]
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
