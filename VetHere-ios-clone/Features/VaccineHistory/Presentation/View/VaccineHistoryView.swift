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
                                    BookSummaryInfoRowComponent(label: "Nama Hewan", value: petName)
                                        .padding(.horizontal, 20)
                                }
                                
                                Divider()
                                
                                VStack(alignment: .leading) {
                                    Text("Nama Vaksin")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Text("\(detail.vaccine_name)")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .padding(.horizontal, 20)
          
                              
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("Riwayat Vaksin")
                .navigationBarTitleDisplayMode(.inline)
                .cornerRadius(10)
               
            }
        } .background(Color(UIColor.systemGroupedBackground))
    }
}

struct VaccineHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDetails = [
            vaccine_history_details(
                vaccine_history_detail_id: UUID(),
                vet_name: "he",
                vaccine_name: "hello",
                createdAt: Date(),
                updatedAt: Date()),
          
        ]
        
        let mockVaccineHistory = vaccine_history(vaccine_history_id: UUID(), vaccine_history_details: mockDetails)
        
        VaccineHistoryView(
            AppCoordinator(),
            vetName: "Sunrise Veterinary Clinic",
            doctorName: "Dr. Jane Doe",
            petName: "Buddy",
            vaccine: mockVaccineHistory
        )
    }
}
