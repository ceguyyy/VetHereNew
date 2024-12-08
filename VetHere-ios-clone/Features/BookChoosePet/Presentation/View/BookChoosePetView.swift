//
//  BookChoosePet.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//
import SwiftUI

struct BookChoosePetView: View {
    @StateObject private var viewModel: BookChoosePetViewModel
    @State private var selectedPet: MyPetMockUp? = nil
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
        VStack {
            if viewModel.myPets.isEmpty {
                Text("Tidak ada peliharaan Anda. Silakan tambahkan peliharaan baru.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding()
                Spacer()
            } else {
                List {
                    Section(header: Text("PELIHARAAN SAYA").font(.subheadline).foregroundColor(.secondary)) {
                        ForEach(viewModel.myPets) { pet in
                            HStack {
                                ImageView(imageURL: pet.imageUrl, width: 40, height: 40).clipShape(Circle())
                                VStack(alignment: .leading) {
                                    Text(pet.name)
                                        .font(.body)
                                    Text(pet.breed)
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
                CustomButtonComponent(
                    title: "Peliharaan Baru",
                    action: {
                        print("Add new pet tapped")
                    },
                    isDisabled: false,
                    backgroundColor: Color.white,
                    textColor: .black
                )
                
                CustomButtonComponent(
                    title: "Pilih Peliharaan",
                    action: {
                        print("Confirm \(selectedPet?.name) selection tapped")
                    },
                    isDisabled: selectedPet == nil,
                    backgroundColor: selectedPet == nil ? Color.gray.opacity(0.2) : Color.blue,
                    textColor: .white
                )
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
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
