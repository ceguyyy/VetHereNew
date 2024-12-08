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
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol

    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var loadingState: LoadingState = .loading
    
    @Published var pets: [GetUserPetsResponseDto] = []
    
    
    enum InputGesture{
        case didFetchMyPet
        case didChoosePet
    }

    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func onInput(_ inputGesture:InputGesture){
        switch inputGesture{
        case .didChoosePet:
//            coordinator.push(.myPetDetail(petId: selectedPet!.petId))
            print("DidChoosePet")
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
                image: dto.pet_image,
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
            let service = PetService.getMyPet(params: dto)
            
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
    
//    func getUserPetDetail(petId: String) {
//        Task { @MainActor [weak self] in
//            guard let self = self else { return }
//            
//            let dto = GetPetDetailRequestDto(pet_id: petId)
//            let service = PetService.getUserPetDetail(params: dto)
//            let request = await networkManager.makeRequest(service, output: GetPetDetailResponseDto.self)
//            
//            switch request {
//            case .success(let response):
//                if response.meta.success, let data = response.data {
//                    // Map vaccine histories
//                    let vaccineHistories = data.vaccine_histories?.map { record in
//                        VaccineHistory(
//                            vaccineId: record.vaccine_id,
//                            vaccineName: record.vaccine_name,
//                            vetName: record.vet_name,
//                            vaccineDate: record.vaccine_date
//                        )
//                    }
//                    
//                    // Map medical record details
//                    let medicalRecordDetails = data.medical_record?.medical_record_details.map { detail in
//                        MedicalRecordDetail(
//                            medicalRecordId: detail.medical_record_detail_id,
//                            vetName: detail.vet_name,
//                            diagnosis: detail.diagnosis,
//                            treatment: detail.treatment,
//                            date: detail.created_at
//                        )
//                    } ?? []
//                    
//                    // Map medical record
//                    let medicalRecord = data.medical_record.map { record in
//                        MedicalRecord(
//                            medicalRecordId: record.medical_record_id,
//                            medicalRecordDetails: medicalRecordDetails
//                        )
//                    }
//                    
//                    let mockMedicalRecord = MedicalRecord(
//                        medicalRecordId: "1",
//                        medicalRecordDetails: [
//                            MedicalRecordDetail(
//                                medicalRecordId: "1",
//                                vetName: "Dr. Smith",
//                                diagnosis: "Healthy",
//                                treatment: "Vaccination",
//                                date: "08/12/2024"
//                            ),
//                            MedicalRecordDetail(
//                                medicalRecordId: "2",
//                                vetName: "Dr. John",
//                                diagnosis: "Injury",
//                                treatment: "Bandaging",
//                                date: "10/11/2024"
//                            ),
//                            MedicalRecordDetail(
//                                medicalRecordId: "3",
//                                vetName: "Dr. Alice",
//                                diagnosis: "Skin Infection",
//                                treatment: "Antibiotics",
//                                date: "11/15/2024"
//                            ),
//                            MedicalRecordDetail(
//                                medicalRecordId: "4",
//                                vetName: "Dr. Bob",
//                                diagnosis: "Allergy",
//                                treatment: "Antihistamines",
//                                date: "12/01/2024"
//                            )
//                        ]
//                    )
//                    
//                    // Map full pet details
//                    let petDetail = Pet(
//                        petId: data.pet_id,
//                        petName: data.pet_name,
//                        petType: data.pet_type,
//                        petImage: data.pet_image,
//                        petWeight: data.pet_weight,
//                        petDOB: data.pet_dob,
//                        petBreed: data.pet_breed,
//                        petColor: data.pet_color,
//                        medicalRecord: mockMedicalRecord,
//                        vaccineHistory: vaccineHistories ?? []
//                    )
//                    
//                    selectedPet = petDetail
//                    
//                } else {
//                    print("Failed to fetch pet details: \(response.meta.message)")
//                }
//                
//            case .failure(let error):
//                print("Error fetching pet details: \(error)")
//            }
//        }
//    }
//}
