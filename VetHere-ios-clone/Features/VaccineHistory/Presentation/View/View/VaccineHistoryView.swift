//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//


import SwiftUI

struct VaccineHistoryView: View {
    @StateObject private var viewModel: VaccineHistoryViewModel
    let date: String
    let vetName:String
    let doctorName: String
    let vaccineName: String
    let petName:String
    
    init(_ coordinator: any AppCoordinatorProtocol, date: String, vetName: String, doctorName: String, vaccineName: String, petName: String) {
        self._viewModel = StateObject(wrappedValue: VaccineHistoryViewModel(coordinator))
        self.date = date
        self.vetName = vetName
        self.doctorName = doctorName
        self.vaccineName = vaccineName
        self.petName = petName
       }
    
    var body: some View {
        NavigationView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("\(date)")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Nama Klinik")
                                    .font(.subheadline)
                                Spacer()
                                Text("\(vetName)")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Nama Dokter")
                                    .font(.subheadline)
                                Spacer()
                                Text("\(doctorName)")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Nama Peliharaan")
                                    .font(.subheadline)
                                Spacer()
                                Text("\(petName)")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                        }
                        Divider()
                        
                        Text("Nama Vaksin")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("\(vaccineName)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("Vaksin")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
    }

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        VaccineHistoryView(appCoordinator, date: "2024-11-24T15:45:41.097558+07:00", vetName: "Vet Clinic 9", doctorName: "James", vaccineName: "IOS", petName: "Udin")
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
