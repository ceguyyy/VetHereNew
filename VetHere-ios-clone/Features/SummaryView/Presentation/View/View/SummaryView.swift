//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct SummaryView: View {
    @StateObject private var viewModel: ChooseScheduleViewModel
    
    var vetid: UUID?
    var vetName: String?
    var doctorId: UUID?
    var doctorName: String?
    var petId: UUID?
    var petName: String?
    var selectedDate: Date?
    var selectedTime: Date?
    var notes: String?
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: ChooseScheduleViewModel(coordinator))
    }
    var body: some View {
        VStack {
            List {
                Section {
                    VStack(spacing: 16) {
                        Text("Ringkasan Pemesanan")
                            .font(.custom("SF Pro", size: 22).weight(.heavy))
                            .padding(12)
                        InfoRowComponent(label: "Tanggal", value: selectedDate != nil ? formattedTimeDDMMYY(selectedDate!) : "-")
                        InfoRowComponent(label: "Waktu", value: selectedTime != nil ? formattedTimeHHMM(selectedTime!) : "-")
                        
                        Divider()
                        
                        InfoRowComponent(label: "Nama Klinik", value: vetName ?? "-")
                        InfoRowComponent(label: "Nama Dokter", value: doctorName ?? "-")
                        InfoRowComponent(label: "Nama Hewan", value: petName ?? "-")

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
                CustomButtonComponent(title: "Lanjutkan", action: { print(
                    "Tap Schedule")
                }, isDisabled: false, backgroundColor: .white, textColor: .blue)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            
            
        }
        .navigationBarTitle("Ringkasan")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        SummaryView(appCoordinator)
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
