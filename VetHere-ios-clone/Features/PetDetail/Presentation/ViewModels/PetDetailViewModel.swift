//
//  MyPetViewModel.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import Foundation
import SwiftUICore

class PetDetailViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol

    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var loadingState: LoadingState = .loading
    
    @Published var petsDetail: GetPetDetailResponseDto?
    
    
    enum InputGesture{
        case didFetchMyPetDetail
    }

    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    enum goAction{
        case goToMedicalRecord(vetName : String,doctorName: String, petName: String, treament: String, diagnosis: String, createdAt: String)
        case goToVaccineHistory(vetName : String,doctorName: String, petName: String, vaccineName: String, vaccineDate: String)
    }

    
    func onInput(_ inputGesture:InputGesture, petId:UUID){
        switch inputGesture{
        case .didFetchMyPetDetail:
            print("fetching pet detail..")
            getUserPetsDetail(petId: petId)
        }
    }
    
    func goToDetails(_ goAction:goAction){
        switch goAction{
        
        case .goToVaccineHistory(vetName: let vetName, doctorName: let doctorName, petName: let petName, vaccineName: let vaccineName, vaccineDate: let vaccineDate):
            coordinator.push(.vaccineHistory(vetName: vetName, doctorName: doctorName, petName: petName, vaccineName: vaccineName, vaccineDate: vaccineDate))
        case .goToMedicalRecord(vetName: let vetName, doctorName: let doctorName, petName: let petName, treament: let treament, diagnosis: let diagnosis, createdAt: let createdAt):
            coordinator.push(.medicalRecord(vetName: vetName, doctorName: doctorName, petName: petName, treatment: treament, createdAt: createdAt, diagnosis: diagnosis))
        }
    }
    
    func transformDTOtoPet() -> pet? {
        guard let dto = petsDetail else {
            return nil
        }
        
        let medicalRecord = dto.medical_record.map { record in
            medical_records(
                medicalRecordId: UUID(uuidString: record.medical_record_id) ?? UUID(),
                medicalRecordDetails: record.medical_record_details.map { detail in
                    medical_record_details(
                        medicalRecordId: UUID(uuidString: detail.medical_record_detail_id) ?? UUID(),
                        vetName: detail.vet_name,
                        diagnosis: detail.diagnosis,
                        treatment: detail.treatment,
                        createdAt: formattedDateToStringDDMMYYYY(detail.created_at) ?? Date(),
                        updatedAt: Date())
    
                }
            )
        }
        
        let vaccineHistories = dto.vaccine_histories.map { history in
            vaccine_history(
                vaccine_history_id: UUID(uuidString: history.vaccine_history_id) ?? UUID(),
                vaccine_history_details: history.vaccine_history_details.map { detail in
                    vaccine_history_details(
                        vaccine_history_detail_id: UUID(uuidString: detail.vaccine_history_detail_id) ?? UUID(),
                        vet_name: detail.vet_name,
                        vaccine_name: detail.vaccine_name,
                        createdAt: formattedDateToStringDDMMYYYY(detail.created_at) ?? Date(),
                        updatedAt: Date())
                }
            )
        }
        
        return pet(
            pet_id: UUID(uuidString: dto.pet_id) ?? UUID(),
            pet_type: dto.pet_type ?? "Unknown",
            pet_breed: dto.pet_breed ?? "Unknown",
            pet_image: dto.pet_image,
            pet_name: dto.pet_name,
            pet_color: dto.pet_color ?? "Unknown",
            pet_dob: dto.pet_dob,
            pet_weight: dto.pet_weight ?? 0,
            medical_record: medicalRecord,
            vaccine_histories: vaccineHistories
        )
    }



    
    func getUserPetsDetail(petId: UUID) {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            self.isLoading = true
            self.errorMessage = nil
            
            let dto = GetPetDetailRequestDto(pet_id: petId.uuidString)
            let service = PetDetailService.getMyPetDetail(params: dto)
            
            let result = await networkManager.makeRequest(service, output: GetPetDetailResponseDto.self)
            
            switch result {
            case .success(let response):
                if let petsDetailData = response.data {
                    self.petsDetail = petsDetailData
                    print("Successfully fetched pets detail")
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
