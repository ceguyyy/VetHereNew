//
//  NewPetView 2.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 09/12/24.
//


import SwiftUI

struct NewPetView: View {
    @State private var selectedUIImage: UIImage? = nil
    @State private var petName: String = ""
    @State private var petWeight: String = ""
    @State private var petDOB: Date = Date()
    @State private var petBreed: String = ""
    @State private var petColor: String = ""
    @State private var showImageSourceActionSheet: Bool = false
    
    @State private var petType: String = "Anjing"
    let petTypes = ["Anjing", "Kucing", "Eksotis", "Hamster", "Lainnya"]
    
    @StateObject var viewModel: NewPetViewModel
    @Binding var isPresented: Bool
    
    init(_ coordinator: any AppCoordinatorProtocol, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: NewPetViewModel(coordinator))
        self._isPresented = isPresented
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
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        showImageSourceActionSheet = true // Show action sheet when tapping on image
                                    }
                            } else {
                                VStack {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 128, height: 128)
                                        .foregroundColor(.gray)
                                        .onTapGesture {
                                            showImageSourceActionSheet = true // Show action sheet when tapping on image
                                        }

                                    Text("Sentuh untuk menambahkan gambar")
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
                        Picker("Tipe Hewan", selection: $petType) {
                            ForEach(petTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        DatePicker("Tanggal Lahir", selection: $petDOB, displayedComponents: .date)
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
                        petType: petType,
                        petDOB: formattedDOB,
                        petBreed: petBreed,
                        petColor: petColor,
                        petImage: selectedUIImage
                    )
                    isPresented = false
                }) {
                    if viewModel.isSaving {
                        ProgressView()
                    } else {
                        Text("Save Pet")
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
            .navigationBarTitle("Tambahkan Hewan Baru", displayMode: .inline)
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
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in }
            )) {
                Alert(
                    title: Text("Notifikasi"),
                    message: Text(viewModel.errorMessage ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
