//
//  MyPet.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 04/12/24.
//

import SwiftUI

struct MyPetView: View {
    @StateObject var viewModel: PetViewModel
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: PetViewModel(coordinator))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    LoadingView()
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage)
                } else if viewModel.transformDTOtoPet().isEmpty {
                    NoFoundView()
                } else {
                    let pets = viewModel.transformDTOtoPet()
                    VStack(alignment: .leading) {
                        
                        List{
                            Section(header: Text("My Pets")){
                                ForEach(pets, id: \.id) { pet in
                                    HStack {
                                        ImageView(imageURL: pet.image, width: 50, height: 50).clipShape(Circle())
                                        
                                        VStack(alignment: .leading) {
                                            Text(pet.name) .font(.body)
                                            Text(pet.type).font(.caption).foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.vertical,4)
                                    .fontWeight(.bold)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        viewModel.goToSchedule(.goToPetDetails(petId: pet.id))
                                        print("Pet ID: \(pet.id)")
                                    }
                                }
                            }
                        }.listStyle(InsetListStyle())
                            .frame(maxWidth: .infinity)
                        
                    }
                }
            }
            .navigationTitle("Hewan Peliharaan")
           
               .refreshable {
                   viewModel.onInput(.didFetchMyPet)
               }
               .onAppear {
                   viewModel.onInput(.didFetchMyPet)
               }
           
          
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.goToSchedule(.goToProfile)
                }) {
                    Image(systemName: "person.circle")
                        .font(.title)
                }
            }
        }
    }
}

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        MyPetView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
