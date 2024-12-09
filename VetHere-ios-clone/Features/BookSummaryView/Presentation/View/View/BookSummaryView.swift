//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct BookSummaryView: View {
    @StateObject private var viewModel: BookSummaryViewModel
    
    var vetId: UUID
    var vetName: String
    var doctorId: UUID
    var doctorName: String
    var petId: UUID
    var petName: String
    var selectedDate: Date
    var selectedTime: Date
    var notes: String
    
    
    init(_ coordinator: any AppCoordinatorProtocol, vetId: UUID, vetName: String, doctorId: UUID, doctorName: String, petId: UUID, petName: String, date: Date, time: Date, notes: String) {
        self._viewModel = StateObject(wrappedValue: BookSummaryViewModel(coordinator))
        
        self.vetId = vetId
        self.vetName = vetName
        self.doctorId = doctorId
        self.doctorName = doctorName
        self.petId = petId
        self.petName = petName
        self.selectedDate = date
        self.selectedTime = time
        self.notes = notes
        
    }
    
    
    var body: some View {
        VStack {
            List {
                Section {
                    VStack(spacing: 16) {
                        Text("Ringkasan Pemesanan")
                            .font(.custom("SF Pro", size: 22).weight(.heavy))
                            .padding(12)
                        BookSummaryInfoRowComponent(label: "Tanggal", value: selectedDate != nil ? formattedTimeDDMMYY(selectedDate) : "-")
                        BookSummaryInfoRowComponent(label: "Waktu", value: selectedTime != nil ? formattedTimeHHMM(selectedTime) : "-")
                        
                        Divider()
                        
                        BookSummaryInfoRowComponent(label: "Nama Klinik", value: vetName ?? "-")
                        BookSummaryInfoRowComponent(label: "Nama Dokter", value: doctorName ?? "-")
                        BookSummaryInfoRowComponent(label: "Nama Hewan", value: petName ?? "-")

                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Catatan")
                                .font(.custom("SF Pro", size: 20).weight(.semibold))
                                .foregroundColor(.black)
                            ScrollView {
                                Text(notes ?? "No Notes")
                                    .font(.custom("SF Pro", size: 13))
                                    .foregroundColor(.black)
                                    .padding(.top, 4)
                            }
                            .frame(height: 124)
                        }
                        .padding(4)
                    }
                    .padding(.horizontal)
                }
            }
            VStack(spacing: 20){
                CustomButtonInsideListComponent(title: "Lanjutkan", action: {
                    viewModel.CreateAppointment(vetId: vetId, doctorId: doctorId, petId: petId, notes: notes, date: selectedDate, time: selectedTime)
                    
                    
                    
                    
                }, isDisabled: false, backgroundColor: .white, textColor: .blue)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            
            
        }
        .background(Color(.systemGray6))
        .navigationBarTitle("Ringkasan")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

//#Preview {
//    @Previewable
//    @StateObject var appCoordinator = AppCoordinator()
//    NavigationStack(path: $appCoordinator.path) {
//        SummaryView(appCoordinator)
//            .navigationDestination(for: Screen.self) { screen in
//                appCoordinator.build(screen)
//            }
//    }
//}
