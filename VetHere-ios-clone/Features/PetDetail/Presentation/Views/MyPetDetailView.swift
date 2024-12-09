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
                if let pet = viewModel.transformDTOtoPet() {
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
                                Text("\(pet.pet_weight ?? 0) kg")
                                    .font(.system(size: 12))
                                Text("•")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                
                                Image(systemName: "pawprint.circle.fill")
                                    .font(.system(size: 12))
                                Text("\(pet.pet_type ?? "No Value")")
                                    .font(.system(size: 12))
                            }
                            
                            HStack {
                                Image(systemName: "calendar")
                                    .font(.system(size: 12))
                                Text("\(pet.pet_dob ?? "No Value")")
                                    .font(.system(size: 12))
                                Text("•")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                Image(systemName: "cube.transparent.fill")
                                    .font(.system(size: 12))
                                Text("\(pet.pet_breed ?? "No Value")")
                                    .font(.system(size: 12))
                                Text("•")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                Image(systemName: "paintpalette.fill")
                                    .font(.system(size: 12))
                                Text("\(pet.pet_color ?? "No Value")")
                                    .font(.system(size: 12))
                            }
                        }
                        .padding(.bottom)
                        
                        List {
                            Section(header: Text("Rekam Medis")) {
                                if let medicalRecords = pet.medical_record, !medicalRecords.isEmpty {
                                    ForEach(medicalRecords, id: \.medicalRecordId) { record in
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(record.medicalRecordDetails.first?.diagnosis ?? "No Diagnosis")
                                                    .font(.headline)
                                                Text(record.medicalRecordDetails.first?.date ?? "No Date")
                                                    .font(.subheadline)
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.vertical, 4)
                                    }
                                } else {
                                    Text("No medical records available")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }


                            Section(header: Text("Vaksin")) {
                                if let vaccineHistories = pet.vaccine_histories, !vaccineHistories.isEmpty {
                                    ForEach(vaccineHistories, id: \.vaccineId) { vaccine in
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(vaccine.vaccineName)
                                                    .font(.headline)
                                                Text(vaccine.vaccineDate ?? "No Date")
                                                    .font(.subheadline)
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.vertical, 4)
                                    }
                                } else {
                                    Text("No vaccine history available")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
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
