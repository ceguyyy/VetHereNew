//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct MedicalRecordView: View {
    @StateObject private var viewModel: MedicalRecordViewModel
    
    let vetName: String
    let doctorName: String
    let petName: String
    let treatment: String
    let createdAt: String
    let diagnosis: String
    
    
    init(_ coordinator: any AppCoordinatorProtocol, vetName: String, doctorName: String, petName: String, treatment: String, createdAt:String, diagnosis: String) {
        self._viewModel = StateObject(wrappedValue: MedicalRecordViewModel(coordinator))
        self.vetName = vetName
        self.doctorName = doctorName
        self.petName = petName
        self.treatment = treatment
        self.createdAt = createdAt
        self.diagnosis = diagnosis
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Spacer()
                                    Text("\(createdAt)")
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
                                    
                                    Text("\(diagnosis)")
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
                                    
                                    Text("\(treatment)")
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
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(10)
        .navigationTitle("Riwayat Rekam Medis")
        .navigationBarTitleDisplayMode(.inline)
            }
           
        }


