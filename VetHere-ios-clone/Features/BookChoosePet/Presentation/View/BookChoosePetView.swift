//
//  BookChoosePet.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//
import SwiftUI

struct BookChoosePetView: View {
    @StateObject private var viewModel: MyPetViewModel
    @State private var selectedPet: Pet? = nil
    @State private var showNewPetSheet: Bool = false
    let vetId: UUID
    let vetName: String
    let doctorId: UUID
    let doctorName: String
    
    init(
        _ coordinator: any AppCoordinatorProtocol, vetId: UUID, vetName: String, doctorId: UUID, doctorName: String
    ) {
        self._viewModel = StateObject(
            wrappedValue: MyPetViewModel(coordinator)
        )
        self.vetId = vetId
        self.vetName = vetName
        self.doctorId = doctorId
        self.doctorName = doctorName
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
            }
             else if viewModel.transformDTOtoPet().isEmpty {
                NoFoundView()
                Spacer()
            } else {
                List {
                    let pets = viewModel.transformDTOtoPet()
                    Section(header: Text("PELIHARAAN SAYA").font(.subheadline).foregroundColor(.secondary)) {
                        ForEach(pets, id: \.id) { pet in
                            HStack {
                                ImageView(imageURL: pet.image, width: 40, height: 40).clipShape(Circle())
                                VStack(alignment: .leading) {
                                    Text(pet.name)
                                        .font(.body)
                                    Text(pet.type)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                            .fontWeight(selectedPet?.id == pet.id ? .bold : .regular)
                            .foregroundColor(selectedPet?.id == pet.id ? .black : .black.opacity(0.75))
                            .cornerRadius(8)
                            .onTapGesture {
                                withAnimation {
                                    selectedPet = selectedPet?.id == pet.id ? nil : pet
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .frame(maxHeight: .infinity)
            }
            
            VStack(spacing: 20) {
                CustomButtonInsideListComponent(
                    title: "Peliharaan Baru",
                    action: {
                        
                        
                        showNewPetSheet = true
                        
                    },
                    isDisabled: false,
                    backgroundColor: Color.white,
                    textColor: .black
                )            .sheet(isPresented: $showNewPetSheet) {
                    NewPetView(AppCoordinator(), isPresented: $showNewPetSheet)
                }
                
                CustomButtonInsideListComponent(
                    title: "Pilih Peliharaan",
                    action: {
                        if let selectedPet = selectedPet {
                            viewModel.goToSchedule(.goToSchedule(
                                vetid: vetId,
                                vetName: vetName,
                                doctorId: doctorId,
                                DoctorName: doctorName,
                                petId: selectedPet.id,
                                petName: selectedPet.name
                            ))
                        }

                    },
                    isDisabled: selectedPet == nil,
                    backgroundColor: selectedPet == nil ? Color.gray.opacity(0.2) : Color.blue,
                    textColor: .white
                )
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
        .refreshable {
            viewModel.onInput(.didFetchMyPet)
        }
        .onAppear {
            viewModel.onInput(.didFetchMyPet)
        }
        .background(Color(.systemGray6))
        .navigationTitle("Pilih Peliharaan")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        BookChoosePetView(appCoordinator, vetId: UUID(), vetName: "1", doctorId: UUID(), doctorName: "")
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
