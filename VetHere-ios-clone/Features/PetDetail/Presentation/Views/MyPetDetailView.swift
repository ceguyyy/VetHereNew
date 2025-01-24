//
//  MyPetDetailView.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//
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
        // Simplify StateObject initialization
        let viewModel = PetDetailViewModel(coordinator)
        self._viewModel = StateObject(wrappedValue: viewModel)
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

                        List {
                            Section(header: Text("Rekam Medis")) {
                                if let medicalRecords = pet.medical_record?.medicalRecordDetails, !medicalRecords.isEmpty {
                                    ForEach(medicalRecords, id: \.self) { detail in
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                HStack {
                                                    Text(detail.treatment)
                                                    Text("-")
                                                    Text(detail.vetName)
                                                }
                                                HStack {
                                                    let date = formattedDateYYYYMMDD(detail.createdAt)
                                                    Text(date).font(.caption).fontWeight(.light)
                                                }
                                            }
                                            .padding(.vertical, 4)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.blue)
                                        }.onTapGesture{
                                            let date = formattedDateYYYYMMDD(detail.createdAt)
                                            viewModel.goToDetails(.goToMedicalRecord(vetName: detail.vetName, doctorName: "", petName: pet.pet_name, treament: detail.treatment, diagnosis: detail.diagnosis, createdAt: date))
                                        }
                                    }
                                } else {
                                    Text("Tidak Ada Rekam Medis.")
                                }
                            }

                            Section(header: Text("Vaksin")) {
                                if let vaccine = pet.vaccine_histories?.vaccine_history_details, !vaccine.isEmpty {
                                    ForEach(vaccine, id: \.self) { detail in
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                HStack {
                                                    Text(detail.vaccine_name)
                                                    Text("-")
                                                    Text(detail.vet_name)
                                                }
                                                HStack {
                                                    let date = formattedDateYYYYMMDD(detail.createdAt)
                                                    Text(date).font(.caption).fontWeight(.light)
                                                }
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.blue)
                                        }
                                        .onTapGesture {
                                            viewModel.goToDetails(.goToVaccineHistory(vetName: detail.vet_name, doctorName: "", petName: detail.vet_name, vaccineName: detail.vaccine_name, vaccineDate: formattedDateYYYYMMDD(detail.createdAt)))
                                        }
                                        .padding(.vertical, 4)
                                    }
                                } else {
                                    Text("Tidak Ada Vaksin.")
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                        .padding(.bottom)
                    }
                }
            }
        }
        .onAppear {
            viewModel.onInput(.didFetchMyPetDetail, petId: petId)
        }
    }
}

#Preview {
    MyPetDetailView(AppCoordinator(), petId: UUID())
}
