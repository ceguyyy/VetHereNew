//
//  MyPetDetailView.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import SwiftUI

struct MyPetDetailView: View {
    @StateObject var viewModel: PetDetailViewModel
    let petId: UUID
    
    init(
        _ coordinator: any AppCoordinatorProtocol,
        petId: UUID
    ) {
        self._viewModel = StateObject(
            wrappedValue: PetDetailViewModel(coordinator)
        )
        self.petId = petId
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: errorMessage)
            } else {
                if let pet = viewModel.petsDetail {
                    VStack {
                        ImageView(imageURL: pet.pet_image, width: 200, height: 200)
                        Text(pet.pet_name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom)

                        VStack {
                            HStack(alignment: .center) {
                                Image(systemName: "scalemass.fill")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 12))
                                Text("0 kg")
                                    .font(.system(size: 12))
                                Text("•")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                
                                Image(systemName: "pawprint.circle.fill")
                                    .font(.system(size: 12))
                                Text("Jenis Peliharaan")
                                    .font(.system(size: 12))
                            }
                            
                            HStack {
                                Image(systemName: "calendar")
                                    .font(.system(size: 12))
                                Text("\(pet.pet_dob)")
                                    .font(.system(size: 12))
                                Text("•")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                Image(systemName: "cube.transparent.fill")
                                    .font(.system(size: 12))
                                Text("Breed")
                                    .font(.system(size: 12))
                                Text("•")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                Image(systemName: "paintpalette.fill")
                                    .font(.system(size: 12))
                                Text("\(pet.pet_color)")
                                    .font(.system(size: 12))
                            }
                        }
                        .padding(.bottom)
                        
                        List {
                            Section {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Name Vaksin - Nama Klinik")
                                        Text("dd/mm/yyyy hh:mm")
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            } header: {
                                Text("Vaksin")
                            }
                            
                            Section {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Tindakan - Nama Klinik")
                                        Text("dd/mm/yyyy hh:mm")
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                            } header: {
                                Text("Rekam Medis")
                            }
                        }
                    }
                } else {
                    Text("Pet details not available")
                        .font(.title)
                        .padding()
                }
            }
        }  .onAppear {
            viewModel.onInput(.didFetchMyPetDetail, petId: petId)
        }
      
    }
}

#Preview {
    MyPetDetailView(AppCoordinator(), petId: UUID())
}
