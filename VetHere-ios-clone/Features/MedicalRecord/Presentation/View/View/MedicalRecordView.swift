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
            ScrollView{
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Spacer()
                        Text("\(date)")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                        Spacer()
                    }
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        BookSummaryInfoRowComponent(label: "Nama Klinik", value: vetName).padding(.horizontal,20)
                        
                        
                        BookSummaryInfoRowComponent(label: "Nama Dokter", value: doctorName).padding(.horizontal,20)
                        
                    }
                    
                    
                    Divider()
                    
                    VStack(alignment:.leading){
                        Text("Diagnosa")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("\(diagnose)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(.horizontal,20)
                    
                    Divider()
                    
                    VStack(alignment:.leading){
                        Text("Tindakan")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("\(action)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(.horizontal,20)
                    
                    
                    Spacer()
                }
            }
                    .cornerRadius(10)
                    .background(Color(UIColor.systemGroupedBackground))
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
