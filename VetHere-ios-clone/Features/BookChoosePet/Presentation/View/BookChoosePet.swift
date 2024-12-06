//
//  BookChoosePet.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct BookChoosePet: View {
    @StateObject private var viewModel:BookChoosePetViewModel
    let vetId: UUID
    let vetName: String
    let doctorId: UUID
    let doctorName: String
    
    init(
        _ coordinator: any AppCoordinatorProtocol, vetId: UUID, vetName: String, doctorId: UUID, doctorName: String
    ) {
        self._viewModel = StateObject(
            wrappedValue: BookChoosePetViewModel(coordinator)
        )
        self.vetId = vetId
        self.vetName = vetName
        self.doctorId = doctorId
        self.doctorName = doctorName
    }
    
    var body: some View {
        Text(vetId.uuidString)
        Text(vetName)
        Text(doctorId.uuidString)
        Text(doctorName)
    }
}


#Preview {
  @Previewable
  @StateObject var appCoordinator = AppCoordinator()
  NavigationStack(path: $appCoordinator.path) {
      BookChoosePet(appCoordinator, vetId: UUID(), vetName: "1", doctorId: UUID(), doctorName: "")
      .navigationDestination(for: Screen.self) { screen in
        appCoordinator.build(screen)
      }
  }
}
