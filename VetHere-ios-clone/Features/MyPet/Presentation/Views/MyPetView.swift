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
            List(viewModel.pets, id: \.petId) { pet in // Using petId as the unique identifier
                HStack {
                    ImageView(imageURL: pet.petImage, width: 40, height: 40).clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(pet.petName)
                            .font(.body)
                        Text(pet.petType!)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
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
