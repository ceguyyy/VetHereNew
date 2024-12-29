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
    let vetName: String
    let doctorName: String
    let petName: String
    
    init(_ coordinator: any AppCoordinatorProtocol, vetName: String, doctorName: String, petName: String, medicalRecord: medical_records) {
        self._viewModel = StateObject(wrappedValue: MedicalRecordViewModel(coordinator))
        self.vetName = vetName
        self.doctorName = doctorName
        self.petName = petName
        self.medicalRecord = medicalRecord
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if medicalRecord.medicalRecordDetails.isEmpty {
                        VStack {
                            Text("No medical record details available.")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .padding()
                        }
                    } else {
                        ForEach(medicalRecord.medicalRecordDetails, id: \.medicalRecordId) { detail in
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Spacer()
                                    Text("\(detail.createdAt.formatted(.dateTime.year().month().day()))")
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(.primary)
                                        .padding()
                                    Spacer()
                                }
                                
                                Divider()
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    BookSummaryInfoRowComponent(label: "Nama Klinik", value: vetName)
                                        .padding(.horizontal, 20)
                                    
                                    BookSummaryInfoRowComponent(label: "Nama Dokter", value: doctorName)
                                        .padding(.horizontal, 20)
                                }
                                
                                Divider()
                                
                                VStack(alignment: .leading) {
                                    Text("Diagnosa")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Text("\(detail.diagnosis)")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .padding(.horizontal, 20)
                                
                                Divider()
                                
                                VStack(alignment: .leading) {
                                    Text("Tindakan")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Text("\(detail.treatment)")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .padding(.horizontal, 20)
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                           
                        }
                    }
                }
                .cornerRadius(10)
                .padding()
                .navigationTitle("Riwayat Rekam Medis")
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}


#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        MedicalRecordView(
            appCoordinator,
            vetName: "Klinik Indah",
            doctorName: "Aji",
            petName: "Arif",
            medicalRecord: medical_records(
                medicalRecordId: UUID(),
                medicalRecordDetails: [
                    medical_record_details(
                        medicalRecordId: UUID(),
                        vetName: "Klinik Indah",
                        diagnosis: "Muntaber",
                        treatment: "Minum Obat 3x sehari",
                        createdAt: Date(),
                        updatedAt: Date()
                    )
                ]
            )
        )
    }
}
