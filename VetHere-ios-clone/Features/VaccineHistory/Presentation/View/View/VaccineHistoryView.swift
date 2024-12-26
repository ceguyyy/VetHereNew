//
//  VaccineHistoryView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//


import SwiftUI

struct VaccineHistoryView: View {
    @StateObject private var viewModel: VaccineHistoryViewModel
    
    let vaccine: vaccine_history
    let vetName: String
    let doctorName: String
    let petName: String
    
    init(_ coordinator: any AppCoordinatorProtocol, vetName: String, doctorName: String, petName: String, vaccine: vaccine_history) {
        self._viewModel = StateObject(wrappedValue: VaccineHistoryViewModel(coordinator))
        self.vetName = vetName
        self.doctorName = doctorName
        self.petName = petName
        self.vaccine = vaccine
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if vaccine.vaccine_history_details.isEmpty {
                        
                        VStack {
                            Text("No vaccine details available.")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .padding()
                        }
                    } else {
                        ForEach(vaccine.vaccine_history_details, id: \.vaccine_history_detail_id) { detail in
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("\(detail.createdAt.formatted(.dateTime.year().month().day()))")
                                        .font(.headline)
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
                                    BookSummaryInfoRowComponent(label: "Nama Hewan", value: petName)
                                        .padding(.horizontal, 20)
                                }
                                
                                Divider()


                                Text("Nama Vaksin")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text("\(detail.vaccine_name)")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("Vaksin")
                .navigationBarTitleDisplayMode(.inline)
                .cornerRadius(10)
                .background(Color(UIColor.systemGroupedBackground))
            }
        }
    }
}
