//
//  EditProfileView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 26/12/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var selectedUIImage: UIImage? = nil
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var showImageSourceActionSheet: Bool = false

    @StateObject var viewModel: ProfileViewModel

    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(coordinator))
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

                                    Text("Tap to add an image")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    }

                    Section(header: Text("Information")) {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                    }
                }
                .listStyle(InsetGroupedListStyle())

                Spacer()

                Button(action: {
                  
                    print("ini fecthing update?")
         
                    viewModel.validateAndSavePet(firstName: firstName, lastName: lastName, image: selectedUIImage)
                }) {
                    if viewModel.isSaving {
                        ProgressView()
                    } else {
                        Text("Save")
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
            .navigationBarTitle("Update Profile", displayMode: .inline)
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(image: $selectedUIImage, sourceType: viewModel.imagePickerSource)
            }
            .actionSheet(isPresented: $showImageSourceActionSheet) {
                ActionSheet(
                    title: Text("Choose Image Source"),
                    buttons: [
                        .default(Text("Camera")) {
                            viewModel.showImagePickerForCamera()
                        },
                        .default(Text("Choose from Gallery")) {
                            viewModel.showImagePickerForGallery()
                        },
                        .cancel()
                    ]
                )
            }
        }
    }
}


#Preview {
    NavigationStack {
        EditProfileView(AppCoordinator())
    }
}
