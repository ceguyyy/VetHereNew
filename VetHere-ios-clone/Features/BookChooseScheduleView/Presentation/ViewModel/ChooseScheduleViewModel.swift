//
//  NoteViewModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

class ChooseScheduleViewModel: ObservableObject{
    
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var loadingState: LoadingState = .loading
    @Published var schedules: [ScheduleResponseDTO] = []
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    struct ValidationResult {
        var isValid: Bool
        var message: String
    }
    
    
    enum InputGesture {
        case didFetchEmptySchedule(vetId: UUID, doctorId: UUID, appointmentDate: Date)
        
    }
    
    func onInput(_ inputGesture: InputGesture, vetId: UUID,  doctorId: UUID,  appointmentDate: Date) {
        switch inputGesture {
        case .didFetchEmptySchedule:
            print("Success did fetch Detail Vet")
            FetchEmptySchedule(vetId: vetId, doctorId: doctorId, appointmentDate: appointmentDate)
        }
    }
    
    
    func FetchEmptySchedule(vetId: UUID, doctorId: UUID, appointmentDate: Date) {
        Task { @MainActor [weak self] in
            guard let self = self
            else { return }
            self.isLoading = true
            self.errorMessage = nil
            let dto = ScheduleRequestDto(vet_id: vetId.uuidString, doctor_id: doctorId.uuidString, appointment_date: formattedDateYYYYMMDD(appointmentDate))
            let service = getEmptyScheduleService.emptySchedule(params: dto)
            let result = await networkManager.makeRequest(service, output: [ScheduleResponseDTO].self)
            switch result {
            case .success(let response):
                if let dataSchedule = response.data {
                    self.schedules = dataSchedule
                    print("Successfully fetched empty Schedule: \(schedules)")
                } else {
                    self.errorMessage = "No schedule found in your area."
                    print("No data schedule available")
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("Failed to fetch veterinarians: \(error)")
            }
            
            self.isLoading = false
        }
    }
    
}


    
    
