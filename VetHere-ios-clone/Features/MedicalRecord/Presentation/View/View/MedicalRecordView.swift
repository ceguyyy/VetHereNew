//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//




import SwiftUI

struct MedicalRecordView: View {
    @StateObject private var viewModel: MedicalRecordViewModel
    let date: String
    let vetName:String
    let doctorName: String
    let diagnose: String
    let action: String
    let petName:String
    
    init(_ coordinator: any AppCoordinatorProtocol, date: String, vetName: String, doctorName: String, diagnose: String, petName: String, action: String) {
        self._viewModel = StateObject(wrappedValue: MedicalRecordViewModel(coordinator))
        self.date = date
        self.vetName = vetName
        self.doctorName = doctorName
        self.diagnose = diagnose
        self.action = action
        self.petName = petName
       }
    
    var body: some View {
        NavigationView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("\(date)")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Nama Klinik")
                                    .font(.subheadline)
                                Spacer()
                                Text("\(vetName)")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Nama Dokter")
                                    .font(.subheadline)
                                Spacer()
                                Text("\(doctorName)")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Nama Peliharaan")
                                    .font(.subheadline)
                                Spacer()
                                Text("\(petName)")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                        }
                        Divider()
                        
                        VStack{
                            
                        }
                        Text("Diagnosa")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("\(diagnose)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Divider()
                        
                        Text("Tindakan")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("\(action)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("Medical Record")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
    }

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        MedicalRecordView(appCoordinator, date: "2024-11-24T15:45:41.097558+07:00", vetName: "Vet Clinic 10", doctorName: "Ucok", diagnose: "Butuh Ditangani", petName: "Ajis", action: "Butuh Ditangani")
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}

//
//import SwiftUI
//
//struct MedicalRecordView: View {
//    @StateObject private var viewModel: MedicalRecordViewModel
//    
//    let userName = "Binus"
//    let userBio = "Happy person"
//    let userProfileImage = "https://thumb.viva.co.id/media/frontend/thumbs3/2023/03/12/640dcafc3d2ac-binus-university_1265_711.jpg"
//
//    init(_ coordinator: any AppCoordinatorProtocol) {
//        self._viewModel = StateObject(wrappedValue: MedicalRecordViewModel(coordinator))
//    }
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Medical Record")
//        }
//    }
//}
//
//#Preview {
//    @Previewable
//    @StateObject var appCoordinator = AppCoordinator()
//    NavigationStack(path: $appCoordinator.path) {
//        ProfileView(appCoordinator)
//            .navigationDestination(for: Screen.self) { screen in
//                appCoordinator.build(screen)
//            }
//    }
//}
