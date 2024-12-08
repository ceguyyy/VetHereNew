//
//  NoteViewModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

class SummaryViewModel: ObservableObject {

  private let networkManager = NetworkManager.shared
  private let authenticationDefaults = AuthenticationUserDefaults.shared
  private let credentialManager = KeychainCredentialManager.shared
  private let coordinator: any AppCoordinatorProtocol

  @Published var errorMessage: String?
  @Published var isLoading: Bool = false
  @Published var loadingState: LoadingState = .loading

  init(_ coordinator: any AppCoordinatorProtocol) {
    self.coordinator = coordinator
  }

  struct ValidationResult {
    var isValid: Bool
    var message: String
  }

  enum InputGesture {
    case DidTapCreateAppointment

  }

  func onInput(
    _ inputGesture: InputGesture, vetId: UUID, doctorId: UUID, petId: UUID, notes: String,
    date: Date, time: Date
  ) {
    switch inputGesture {
    case .DidTapCreateAppointment:
      print("did tap send appointment")
      CreateAppointment(
        vetId: vetId, doctorId: doctorId, petId: petId, notes: notes, date: date, time: time)

    }
  }

  func CreateAppointment(
    vetId: UUID, doctorId: UUID, petId: UUID, notes: String, date: Date, time: Date
  ) {
    Task { @MainActor [weak self] in
      guard let self = self else { return }
      self.isLoading = true
      self.errorMessage = nil
      print("Creating appointment")
      print(
        "vet_id: \(vetId.uuidString), doctor_id: \(doctorId.uuidString), pet_id: \(petId.uuidString), appointment_notes: \(notes), appointment_date: \(formattedDateYYYYMMDD(date)), appointment_time: \(formattedTimeHHMMSS(time))"
      )

      let dto = summaryRequestDTO(
        vet_id: vetId.uuidString, doctor_id: doctorId.uuidString, pet_id: petId.uuidString,
        appointment_notes: notes, appointment_date: formattedDateYYYYMMDD(date),
        appointment_time: formattedTimeHHMMSS(time))
      let jsonData = try? JSONEncoder().encode(dto)
      if let jsonString = String(data: jsonData ?? Data(), encoding: .utf8) {
        print("Request JSON: \(jsonString)")  // Check this output
      }

      let service = SummaryService.sendAppointment(params: dto)
      let request = await networkManager.makeRequest(service, output: summaryResponseDTO.self)
      let response = request.flatMap { response -> Result<Void, NetworkError> in
        guard response.meta.success, let data = response.data else {
          return .failure(.noData)
        }
        print("Succesfully saved to database")
        return .success(())
      }
      switch response {
      case .success(_):
        print("Successfully saved to database")
        coordinator.popToRoot()
        coordinator.push(.successToDatabase)
      case .failure(_):
        print("Error saving to database")
        coordinator.popToRoot()
        coordinator.push(.errorToDatabase)

      }
    }
  }
}
