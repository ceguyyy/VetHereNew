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
        case goToMedicalRecord(date: String,vetName : String,doctorName: String, petName: String, diagnose: String, action: String)
        case goToVaccineHistory(date: String,vetName : String,doctorName: String, petName: String, vaccineName: String)
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

        case .goToMedicalRecord(date: let date, vetName: let vetName, doctorName: let doctorName, petName: let petName, diagnose: let diagnose, action: let action):
            coordinator.push(.medicalRecord(date: date, vetName: vetName, doctorName: doctorName, diagnose: diagnose, action: action, petName: petName))
        case .goToVaccineHistory(date: let date, vetName: let vetName, doctorName: let doctorName, petName: let petName, vaccineName: let vaccineName):
            coordinator.push(.vaccineHistory(date: date, vetName: vetName, doctorName: doctorName, vaccineName: vaccineName, petName: petName))
        }
    }
    
    func transformDTOtoPet() -> PetDetail? {
        guard let dto = petsDetail else {
            return nil
        }
        let medicalRecords: [MedicalRecord] = dto.medical_record?.map { record in
            MedicalRecord(
                medicalRecordId: record.medical_record_id,
                medicalRecordDetails: record.medical_record_details.map { detail in
                    MedicalRecordDetail(
                        medicalRecordId: detail.medical_record_detail_id,
                        vetName: detail.vet_name,
                        diagnosis: detail.diagnosis,
                        treatment: detail.treatment,
                        date: detail.created_at
                    )
                }
            )
        } ?? []

        let vaccineHistories: [VaccineHistory] = dto.vaccine_histories?.map { history in
            VaccineHistory(
                vaccineId: UUID(uuidString: history.vaccine_id) ?? UUID() ,
                vaccineName: history.vaccine_name,
                vetName: history.vet_name,
                vaccineDate: history.vaccine_date
            )
        } ?? []

        return PetDetail(
            id: UUID(uuidString: dto.pet_id) ?? UUID(),
            pet_type: dto.pet_type ?? "Unknown",
            pet_breed: dto.pet_breed ?? "Unknown",
            pet_image: dto.pet_image ?? Constant.ErrorImage,
            pet_name: dto.pet_name,
            pet_color: dto.pet_color ?? "Unknown",
            pet_dob: dto.pet_dob ?? "Unknown",
            pet_weight: 0,
            medical_record: medicalRecords,
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
