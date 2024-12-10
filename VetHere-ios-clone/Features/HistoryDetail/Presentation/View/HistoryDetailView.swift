//
//  HistoryView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 04/12/24.
//

import SwiftUI


struct HistoryDetailView: View {
    
    let date: Date
    let time: String
    let vetName: String
    let doctorName: String
    let petName: String
    let notes: String
    
    @StateObject private var viewModel: HistoryDetailViewModel
    @State private var showNewPetSheet: Bool = false
    
    init(
        _ coordinator: any AppCoordinatorProtocol,
        date: Date,
        time: String,
        vetName: String,
        doctorName: String,
        petName: String,
        notes: String
    ) {
        self.date = date
        self.time = time
        self.vetName = vetName
        self.doctorName = doctorName
        self.petName = petName
        self.notes = notes
        self._viewModel = StateObject(wrappedValue: HistoryDetailViewModel(coordinator))
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Spacer()
                        Text("Ringkasan Pemesanan")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        BookSummaryInfoRowComponent(label: "Tanggal", value: (formattedDateYYYYMMDD(date))).padding(.horizontal,20)
                        
                        
                        BookSummaryInfoRowComponent(label: "Waktu", value: extractTime(from: time) ?? time).padding(.horizontal,20)
                        
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        BookSummaryInfoRowComponent(label: "Nama Klinik", value: vetName).padding(.horizontal,20)
                        
                        
                        BookSummaryInfoRowComponent(label: "Nama Dokter", value: doctorName).padding(.horizontal,20)
                        BookSummaryInfoRowComponent(label: "Nama Hewan", value: petName).padding(.horizontal,20)
                        
                    }
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Catatan")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(notes)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineLimit(nil)
                    }.padding(.horizontal,20)
                    Spacer()
                }
            }.cornerRadius(10)
            .background(Color(UIColor.systemGroupedBackground))
            .padding()
            navigationTitle("Ringkasan Pemesanan")
            .navigationBarTitleDisplayMode(.inline)
              }
          }
    }

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetailView(
            AppCoordinator(),
            date: Date(),
            time: "8:00 AM",
            vetName: "Klinik Lorem",
            doctorName: "Dokter Lorem",
            petName: "Alpha",
            notes: "Keluhan Lorem ipsum dolor sit amet, consectetur adipiscing elit..."
        )
    }
}
