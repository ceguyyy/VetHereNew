
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
        case goToHistoryDetails(date: Date, time: String, vetName: String, doctorName: String, petName:String, notes:String, status:String)
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
        case .goToHistoryDetails(date: let date, time: let time, vetName: let vetName, doctorName: let doctorName, petName: let petName, notes: let notes, status: let status):
            coordinator.push(.historyDetailView(date: date, time: time, vetName: vetName, doctorName: doctorName, PetName: petName, notes: notes, status: status))
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
        
    func transformDTOtoAppoinment() -> [appoinments]{
            return history.map {
                dto in
                appoinments(appointment_id:UUID(uuidString: dto.appointment_id) ?? UUID(),
                            vet_name: dto.vet_name,
                            doctor_name: dto.doctor_name,
                            pet_name: dto.pet_name,
                            appointment_notes: dto.appointment_notes,
                            appointment_date: formattedDateToStringDDMMYYYY(dto.appointment_date) ?? Date(),
                            appointment_time: dto.appointment_time,
                            appointment_status: dto.appointment_status
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
    
    func statusColor(for status: String) -> Color {
          switch status {
          case "Accepted":
              return .green
          case "Waiting":
              return .orange
          case "Rejected":
              return .red
          case "Finished":
              return .blue
          default:
              return .secondary
          }
      }
        
    }

