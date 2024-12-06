//
//  MyPet.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 04/12/24.
//

import SwiftUI

struct MyPetView: View {
    @StateObject var viewModel : PetViewModel
    init(
        _ coordinator: any AppCoordinatorProtocol
    ) {
        self._viewModel = StateObject(
            wrappedValue: PetViewModel(coordinator)
        )
    }
    var body: some View {
        VStack{
            PetHeaderComponent()
//            List(pet, id:\.id){ pet in
//                PetRow(imageUrl: pet., petName: <#T##String#>, petType: <#T##String#>)(pet)
//                
//            }
        }
        .onAppear{
            viewModel.GetUserPets()
        }
    }
}

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path){
        MyPetView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
