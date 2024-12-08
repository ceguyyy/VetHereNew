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
    @Published var selectedPet:Pet?
    
    enum InputGesture{
        case DidChoosePet
    }
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func onInput(_ inputGesture:InputGesture){
        switch inputGesture{
        case .DidChoosePet:
            coordinator.pop()
            coordinator.push(.myPetDetail(petId: selectedPet!.petId))
        }
    }
    
    func getUserPets(){
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
                            petImage: pet.pet_image ?? "",
                            petWeight: nil,
                            petDOB: nil,
                            petBreed: nil,
                            petColor: nil,
                            medicalRecord: nil,
                            vaccineHistory: []
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
    
    func getUserPetDetail(petId: String) {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            let dto = GetPetDetailRequestDto(pet_id: petId)
            let service = PetService.getUserPetDetail(params: dto)
            let request = await networkManager.makeRequest(service, output: GetPetDetailResponseDto.self)
            
            switch request {
            case .success(let response):
                if response.meta.success, let data = response.data {
                    // Map vaccine histories
                    let vaccineHistories = data.vaccine_histories?.map { record in
                        VaccineHistory(
                            vaccineId: record.vaccine_id,
                            vaccineName: record.vaccine_name,
                            vetName: record.vet_name,
                            vaccineDate: record.vaccine_date
                        )
                    }
                    
                    // Map medical record details
                    let medicalRecordDetails = data.medical_record?.medical_record_details.map { detail in
                        MedicalRecordDetail(
                            medicalRecordId: detail.medical_record_detail_id,
                            vetName: detail.vet_name,
                            diagnosis: detail.diagnosis,
                            treatment: detail.treatment,
                            date: detail.created_at
                        )
                    } ?? []
                    
                    // Map medical record
                    let medicalRecord = data.medical_record.map { record in
                        MedicalRecord(
                            medicalRecordId: record.medical_record_id,
                            medicalRecordDetails: medicalRecordDetails
                        )
                    }
                    
                    let mockMedicalRecord = MedicalRecord(
                        medicalRecordId: "1",
                        medicalRecordDetails: [
                            MedicalRecordDetail(
                                medicalRecordId: "1",
                                vetName: "Dr. Smith",
                                diagnosis: "Healthy",
                                treatment: "Vaccination",
                                date: "08/12/2024"
                            ),
                            MedicalRecordDetail(
                                medicalRecordId: "2",
                                vetName: "Dr. John",
                                diagnosis: "Injury",
                                treatment: "Bandaging",
                                date: "10/11/2024"
                            ),
                            MedicalRecordDetail(
                                medicalRecordId: "3",
                                vetName: "Dr. Alice",
                                diagnosis: "Skin Infection",
                                treatment: "Antibiotics",
                                date: "11/15/2024"
                            ),
                            MedicalRecordDetail(
                                medicalRecordId: "4",
                                vetName: "Dr. Bob",
                                diagnosis: "Allergy",
                                treatment: "Antihistamines",
                                date: "12/01/2024"
                            )
                        ]
                    )
                    
                    // Map full pet details
                    let petDetail = Pet(
                        petId: data.pet_id,
                        petName: data.pet_name,
                        petType: data.pet_type,
                        petImage: data.pet_image,
                        petWeight: data.pet_weight,
                        petDOB: data.pet_dob,
                        petBreed: data.pet_breed,
                        petColor: data.pet_color,
                        medicalRecord: mockMedicalRecord,
                        vaccineHistory: vaccineHistories ?? []
                    )
                    
                    selectedPet = petDetail
                    
                } else {
                    print("Failed to fetch pet details: \(response.meta.message)")
                }
                
            case .failure(let error):
                print("Error fetching pet details: \(error)")
            }
        }
    }
}
