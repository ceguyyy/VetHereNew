//
//  BookChoosePetViewModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import Foundation

class BookChoosePetViewModel: ObservableObject{
    private let networkManager = NetworkManager.shared
    private let authenticationDefaults = AuthenticationUserDefaults.shared
    private let credentialManager = KeychainCredentialManager.shared
    private let coordinator: any AppCoordinatorProtocol
    
    
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
        loadMockPets()
    }
    
    @Published var myPets: [MyPetMockUp] = []
    
    private func loadMockPets() {
          myPets = [
            MyPetMockUp(id: UUID(), name: "Buddy", breed: "Golden Retriever", age: 3, imageUrl: Constant.ErrorImage),
            MyPetMockUp(id: UUID(), name: "Luna", breed: "Siamese Cat", age: 2, imageUrl: Constant.ErrorImage),
            MyPetMockUp(id: UUID(), name: "Charlie", breed: "Beagle", age: 4,imageUrl: Constant.ErrorImage),
            MyPetMockUp(id: UUID(), name: "Buddy", breed: "Golden Retriever", age: 3, imageUrl: Constant.ErrorImage),
            MyPetMockUp(id: UUID(), name: "Luna", breed: "Siamese Cat", age: 2, imageUrl: Constant.ErrorImage),
            MyPetMockUp(id: UUID(), name: "Charlie", breed: "Beagle", age: 4,imageUrl: Constant.ErrorImage)
          ]
      }
    
}
