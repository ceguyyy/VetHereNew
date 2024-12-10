
import Foundation
import SwiftUICore

class HistoryViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol
    
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var loadingState: LoadingState = .loading
    
    @Published var history: [GetHistoryResponseDTO] = []
    
    
    
    enum goAction {
        case goToHistoryDetails(date: Date, time: String, vetName: String, doctorName: String, petName:String, notes:String)
        case goToProfile
    }
    
    
    enum InputGesture{
        case didFetchHistory
        
    }
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func goToAction(_ goAction: goAction){
        switch goAction{
        case .goToHistoryDetails(date: let date, time: let time, vetName: let vetName, doctorName: let doctorName, petName: let petName, notes: let notes):
            coordinator.push(.historyDetailView(date: date, time: time, vetName: vetName, doctorName: doctorName, PetName: petName, notes: notes))
        case .goToProfile:
            coordinator.push(.profile)
        }
    }
    
    func onInput(_ inputGesture:InputGesture){
        switch inputGesture{
            
        case .didFetchHistory:
            getHistory()
        }
    }
        
        func transformDTOtoHistory() -> [HistoryModel]{
            return history.map {
                dto in
             
                HistoryModel(id:UUID(uuidString: dto.appointment_id) ?? UUID(),
                             vetName: dto.vet_name,
                             doctorName: dto.doctor_name,
                             petName: dto.pet_name,
                             notes: dto.appointment_notes,
                             date: formattedDateToStringDDMMYYYY(dto.appointment_date) ?? Date(),
                             time: dto.appointment_time
                             )
            }
        }
        
        
        func getHistory() {
            Task { @MainActor [weak self] in
                guard let self = self else { return }
                
                self.isLoading = true
                self.errorMessage = nil
                
                let dto = GetHistoryRequestDto()
                let service = HistoryService.getHistory(params: dto)
                
                let result = await networkManager.makeRequest(service, output: [GetHistoryResponseDTO].self)
                
                switch result {
                case .success(let response):
                    if let historyData = response.data {
                        self.history = historyData
                        print("Successfully fetched History")
                    } else {
                        self.errorMessage = "No History data found."
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
