//
//  NewPetView 2.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 09/12/24.
//


import SwiftUI

struct UpdatePetView: View {
    @State private var selectedUIImage: UIImage? = nil
    @State private var petName: String = ""
    @State private var petWeight: String = ""
    @State private var petDOB: Date = Date()
    @State private var petBreed: String = ""
    @State private var petColor: String = ""
    @State private var showImageSourceActionSheet: Bool = false
    @State private var selectedPetTypeID: String = ""
    
    let petId: UUID
    
    
    
    @StateObject var viewModel: UpdatePetViewModel
    
    init(_ coordinator: any AppCoordinatorProtocol, petId: UUID) {
        self._viewModel = StateObject(wrappedValue: UpdatePetViewModel(coordinator))
        self.petId = petId
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        VStack {
                            if let image = selectedUIImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                 
                                    .onTapGesture {
                                        showImageSourceActionSheet = true
                                    }
                            } else {
                                VStack {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 128, height: 128)
                                        .foregroundColor(.gray)
                                        .onTapGesture {
                                            showImageSourceActionSheet = true
                                        }

                                    Text("Ketuk untuk menambahkan gambar")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    }

                    Section(header: Text("Information")) {
                        TextField("Nama Hewan", text: $petName)
                        TextField("Berat Hewan (kg)", text: $petWeight)
                            .keyboardType(.decimalPad)
                        if viewModel.transformDTOToPetType().isEmpty {
                            ErrorView(message: "Server Error")
                        }else
                        {
                            let petTypeData = viewModel.transformDTOToPetType()
                            Picker("Jenis Hewan", selection: $selectedPetTypeID) {
                                
                                ForEach(viewModel.transformDTOToPetType(), id: \.id) { type in
                                    Text(type.name).tag(type.id)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        DatePicker("Tanggal Lahir", selection: $petDOB, displayedComponents: .date)
                    }
                    .onAppear {
                      viewModel.getPetType()
                      if let firstPetType = viewModel.petTypes.first {
                          selectedPetTypeID = firstPetType.pet_type_id
                      }
                  }
                  

                    Section(header: Text("Informasi Tambahan")) {
                        TextField("Keturunan (Optional)", text: $petBreed)
                        TextField("Warna (Optional)", text: $petColor)
                    }
                }
              
                .listStyle(InsetGroupedListStyle())
             
                Spacer()

                Button(action: {
                    let formattedDOB = formattedDateYYYYMMDD(petDOB)
                        viewModel.validateAndSavePet(
                        petName: petName,
                        petWeight: petWeight,
                        petType: selectedPetTypeID,
                        petDOB: formattedDOB,
                        petBreed: petBreed,
                        petColor: petColor,
                        petImage: selectedUIImage,
                        petId: petId

                    )
                }) {
                    if viewModel.isSaving {
                        ProgressView()
                    } else {
                        Text("Simpan Hewan")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .disabled(viewModel.isSaving)
            }
         
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(image: $selectedUIImage, sourceType: viewModel.imagePickerSource)
            }
            .actionSheet(isPresented: $showImageSourceActionSheet) {
                ActionSheet(
                    title: Text("Pilih Sumber Gambar"),
                    buttons: [
                        .default(Text("Kamera")) {
                            viewModel.showImagePickerForCamera()
                        },
                        .default(Text("Pilih dari Galeri")) {
                            viewModel.showImagePickerForGallery()
                        },
                        .cancel()
                    ]
                )
            }
            
        }
        .refreshable {
            viewModel.getPetType()
            
        }
        .onAppear {
            viewModel.getPetType()
        }
       
        .navigationBarTitle("Pembaruan Hewan Baru", displayMode: .inline)
    }
}

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        UpdatePetView(appCoordinator, petId: UUID())
    }
}
