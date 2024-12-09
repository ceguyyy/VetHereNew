//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//


import SwiftUI

struct BookInputNoteView: View {
    @StateObject private var viewModel: BookInputNoteViewModel
    @State var notes: String = "Catatan:"
    
    let vetId: UUID
    let vetName: String
    let doctorId: UUID
    let doctorName: String
    let petId: UUID
    let petName: String
    let date: Date
    let time: Date
    
    init(_ coordinator: any AppCoordinatorProtocol, vetId: UUID, vetName: String, doctorId: UUID, doctorName: String, petId: UUID, petName: String, date: Date, time: Date) {
        self._viewModel = StateObject(wrappedValue: BookInputNoteViewModel(coordinator))
        
        self.vetId = vetId
        self.vetName = vetName
        self.doctorId = doctorId
        self.doctorName = doctorName
        self.petId = petId
        self.petName = petName
        self.date = date
        self.time = time
        
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Komplain dan Penyakit Peliharaan")
                            .font(.headline)
                            .padding(.top)
                        
                        Divider()
                        
                        TextField("Masukkan catatan...", text: $notes)
                            .frame(height: 200)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .padding(.bottom)
                        
                        Text("Catatan: Pastikan untuk memberikan detail yang lengkap.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
                
            }
            
            VStack(spacing: 20){
                CustomButtonInsideListComponent(title: "Lanjutkan", action: {
                    viewModel.goToDetails(.goToSummary(vetId: vetId, VetName: vetName, DoctorName: doctorName, DoctorId: doctorId, PetId: petId, PetName: petName, appointmentDate: date, appointmentTime: time, notes: notes))
                    
                    
                    
                }, isDisabled: false, backgroundColor: .white, textColor: .accentColor)
            }.padding(.horizontal, 16)
                .padding(.bottom, 20)
        }
        .background(Color(.systemGray6))
        .navigationTitle("Masukkan Catatan")
        .navigationBarTitleDisplayMode(.inline)
      
    }
}

//#Preview {
//    @Previewable
//    @StateObject var appCoordinator = AppCoordinator()
//    NavigationStack(path: $appCoordinator.path) {
//        NoteView(appCoordinator)
//            .navigationDestination(for: Screen.self) { screen in
//                appCoordinator.build(screen)
//            }
//    }
//}
