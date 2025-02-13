//
//  NewPetViewModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 09/12/24.
//
import Foundation
import SwiftUICore
import UIKit

class NewPetViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let coordinator: any AppCoordinatorProtocol
    
    @Published var errorMessage: String?
    @Published var isSaving: Bool = false
    @Published var successMessage: String?
    
    @Published var petName: String = ""
    @Published var petTypeId: String = ""
    @Published var breedId: String = ""
    @Published var petColor: String = ""
    @Published var petDob: String = ""
    @Published var petWeight: String = ""
    @Published var petImage: Data = Data()
    @Published var selectedPetTypeID: String = ""

    
    @Published var petTypes: [GetPetTypeResponseDTO] = []
    
    @Published var showImagePicker: Bool = false
    @Published var imagePickerSource: UIImagePickerController.SourceType = .photoLibrary
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func showImagePickerForCamera() {
        showImagePicker = true
        imagePickerSource = .camera
    }

    func showImagePickerForGallery() {
        showImagePicker = true
        imagePickerSource = .photoLibrary
    }

    enum InputGesture {
        case didSavePet
        case didLoadPetType
    }
    
    func onInput(_ inputGesture: InputGesture, pet_type_id: String, breed_id: String, pet_color: String, pet_dob: String, pet_weight: String, pet_image: Data, pet_Name: String) {
        switch inputGesture {
        case .didSavePet:
            addNewPet(pet_type_id: pet_type_id, breed_id: breed_id, pet_color: pet_color, pet_dob: pet_dob, pet_weight: pet_weight, pet_image: pet_image, pet_name: pet_Name)
        case .didLoadPetType:
            getPetType()
        }
    }
    
    func transformDTOToPetType() -> [PetType] {
        return petTypes.map { dto in
            PetType(
                id: dto.pet_type_id,
                name: dto.pet_type_name
            )
        }
    }
    
    func getPetType() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            self.errorMessage = nil
            self.successMessage = nil
            
            let dto = GetPetTypeRequestDTO()
            let service = NewPetService.getPetType(params: dto)
        
            let result = await networkManager.makeRequest(service, output: [GetPetTypeResponseDTO].self)
            switch result {
                
                
            case .success(let response):
                if let petTypeData = response.data{
                    self.petTypes = petTypeData
                    print("Succesfully fetched pet types")
                }
          
            case .failure(_):
                print("failed load pet types")
            }
            
         
        }
    }


    func addNewPet(pet_type_id: String, breed_id: String, pet_color: String, pet_dob: String, pet_weight: String, pet_image: Data, pet_name: String) {
        Task { @MainActor [weak self] in
            guard let self = self else { return }
            
            self.isSaving = true
            self.errorMessage = nil
            self.successMessage = nil
            
            let dto = NewPetRequestDTO(pet_type_id: pet_type_id, breed_id: breed_id, pet_image: pet_image, pet_name: pet_name, pet_color: pet_color, pet_dob: pet_dob, pet_weight: pet_weight)
            let file = NetworkManager.File(data: pet_image, mimeType: "image/jpeg", filename: "pet_image")
            let service = NewPetService.addNewPet(params: dto, file: file)
            
            let result = await networkManager.makeRequest(service, output: AddNewPetResponseDTO.self)
            
            switch result {
            case .success(let response):
                self.successMessage = "Pet added successfully!"
                self.isSaving = false
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isSaving = false
            }
        }
    }
    
    func validateAndSavePet(
           petName: String,
           petWeight: String,
           petType: String,
           petDOB: String,
           petBreed: String,
           petColor: String,
           petImage: UIImage?
       ) {
           guard !petName.isEmpty, !petType.isEmpty else {
               errorMessage = "Please fill in all required fields."
               return
           }
           
           guard let image = petImage, let imageData = image.jpegData(compressionQuality: 0.8) else {
               errorMessage = "Please select a pet image."
               return
           }
           
           onInput(.didSavePet,
                   pet_type_id: petType,
                   breed_id: petBreed,
                   pet_color: petColor,
                   pet_dob: petDOB,
                   pet_weight: petWeight,
                   pet_image: imageData,
                   pet_Name: petName)
       }
    
    func resetForm() {
        petName = ""
        petTypeId = ""
        breedId = ""
        petColor = ""
        petDob = ""
        petWeight = ""
        petImage = Data()
    }
}
