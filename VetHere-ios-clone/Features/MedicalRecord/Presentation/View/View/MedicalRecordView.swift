//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct MedicalRecordView: View {
    @StateObject private var viewModel: MedicalRecordViewModel
    
    let medicalRecord: medical_records
    let vetName:String
    let doctorName: String
    let petName:String
    
    init(_ coordinator: any AppCoordinatorProtocol,vetName: String, doctorName: String, petName: String, medicalRecord: medical_records) {
        self._viewModel = StateObject(wrappedValue: MedicalRecordViewModel(coordinator))
        self.vetName = vetName
        self.doctorName = doctorName
        self.petName = petName
        self.medicalRecord = medicalRecord
       }
    
    var body: some View {
        NavigationView {
            ScrollView{
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Spacer()
                        Text("\(medicalRecord.medicalRecordDetails.first?.createdAt)")
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
                        
                        Text("\(medicalRecord.medicalRecordDetails.first?.diagnosis)")
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
                        
                        Text("\(medicalRecord.medicalRecordDetails.first?.treatment)")
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

//#Preview {
//    @Previewable
//    @StateObject var appCoordinator = AppCoordinator()
//    NavigationStack(path: $appCoordinator.path) {
//        MedicalRecordView(appCoordinator, date: "2024-11-24T15:45:41.097558+07:00", vetName: "Vet Clinic 10", doctorName: "Ucok", diagnose: "Butuh Ditangani", petName: "Ajis", action: "Butuh Ditangani", medicalRecord: me)
//            .navigationDestination(for: Screen.self) { screen in
//                appCoordinator.build(screen)
//            }
//    }
//}
