//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//


import SwiftUI

struct VaccineHistoryView: View {
    @StateObject private var viewModel: VaccineHistoryViewModel
    
    let vaccine: vaccine_history
    let vetName:String
    let doctorName: String
    let petName:String
    
    init(_ coordinator: any AppCoordinatorProtocol, vetName: String, doctorName: String, petName: String, vaccine: vaccine_history) {
        self._viewModel = StateObject(wrappedValue: VaccineHistoryViewModel(coordinator))
        self.doctorName = doctorName
        self.petName = petName
        self.vetName = vetName
        self.vaccine = vaccine
       }
    
    var body: some View {
        NavigationView {
            ScrollView{
                
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        Spacer()
                        Text("\(vaccine.vaccineDate)")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        BookSummaryInfoRowComponent(label: "Nama Klinik", value: vetName).padding(.horizontal,20)
                        
                        
                        BookSummaryInfoRowComponent(label: "Nama Dokter", value: doctorName).padding(.horizontal,20)
                        
                        BookSummaryInfoRowComponent(label: "Nama Hewan", value: petName).padding(.horizontal,20)
                        
                        
                    }
                    
                    Divider()
                    
                    Text("Nama Vaksin")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("\(vaccine.vaccineName)")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
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

#Preview {
    @Previewable
    @StateObject var appCoordinator = AppCoordinator()
    NavigationStack(path: $appCoordinator.path) {
        VaccineHistoryView(appCoordinator, vetName:"clinic 1", doctorName: "Ucok", petName: "adit", vaccine: vaccine_history(vaccineId: UUID(), vaccineName: "ANti-Parasit", vetName: "Clinic1", vaccineDate: "2022-2-2"))
            .navigationDestination(for: Screen.self) { screen in
                appCoordinator.build(screen)
            }
    }
}
