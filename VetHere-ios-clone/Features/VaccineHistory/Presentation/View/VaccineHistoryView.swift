//
//  VaccineHistoryView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct VaccineHistoryView: View {
    @StateObject private var viewModel: VaccineHistoryViewModel
    

    let vaccineName: String
    let vaccineDate: String
    let vetName: String
    let doctorName: String
    let petName: String
    
    init(_ coordinator: any AppCoordinatorProtocol, vetName: String, doctorName: String, petName: String, vaccineName: String, vaccineDate: String) {
        self._viewModel = StateObject(wrappedValue: VaccineHistoryViewModel(coordinator))
        self.vetName = vetName
        self.doctorName = doctorName
        self.petName = petName
        self.vaccineDate = vaccineDate
        self.vaccineName = vaccineName
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        Spacer()
                        Text(vaccineDate)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        Spacer()
                    }
                   
                    
                    Divider()
                    VStack(alignment: .leading, spacing: 8) {
                        BookSummaryInfoRowComponent(label: "Nama Klinik", value: vetName)
                        BookSummaryInfoRowComponent(label: "Nama Dokter", value: doctorName)
                        BookSummaryInfoRowComponent(label: "Nama Hewan", value: petName)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Nama Vaksin")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(vaccineName)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            
        }.navigationTitle("Riwayat Vaksin")
            .navigationBarTitleDisplayMode(.inline)
    }
}
