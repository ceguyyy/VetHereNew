//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct BookChooseScheduleView: View {
    @StateObject private var viewModel: BookChooseScheduleViewModel
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    
    let vetId: UUID
    let vetName: String
    let doctorId: UUID
    let doctorName: String
    let petId: UUID
    let petName: String
    
    init(_ coordinator: any AppCoordinatorProtocol, vetId: UUID, vetName: String, doctorId: UUID, doctorName: String, petId: UUID, petName: String) {
        self._viewModel = StateObject(wrappedValue: BookChooseScheduleViewModel(coordinator))
        
        self.vetId = vetId
        self.vetName = vetName
        self.doctorId = doctorId
        self.doctorName = doctorName
        self.petId = petId
        self.petName = petName
        
    }
    var body: some View {
        VStack{
            List{
                Section{
                    DatePicker(
                        "Select a date and time",
                        selection: $selectedDate,
                        in: Date()...,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    
                    DatePicker("Time", selection: $selectedTime, displayedComponents: [.hourAndMinute])
                }
            }
            
            VStack(spacing: 20){
                CustomButtonInsideListComponent(title: "Lanjutkan", action: {
                    viewModel.goToDetails(.goToBookNotes(vetId: vetId, VetName: vetName, DoctorName: doctorName, DoctorId: doctorId, PetId: petId, PetName: petName, appointmentDate: selectedDate, appointmentTime: selectedTime))
                    
                    
                    
                    
                    
                    
                }, isDisabled: false, backgroundColor: .white, textColor: .blue)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)

        }
        .background(Color(.systemGray6))
        .navigationTitle("Pilih Jadwal")
        .navigationBarTitleDisplayMode(.inline)
    }
}
//
//#Preview {
//  @Previewable
//  @StateObject var appCoordinator = AppCoordinator()
//  NavigationStack(path: $appCoordinator.path) {
//      BookChooseScheduleView(appCoordinator)
//      .navigationDestination(for: Screen.self) { screen in
//        appCoordinator.build(screen)
//      }
//  }
//}


//Text("emptySchedule") .onTapGesture {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    
//    if let dates = dateFormatter.date(from: "2024-12-12"),
//       let vetIds = UUID(uuidString: "2898f694-7447-473c-b936-a269cfea6ffe"),
//       let doctorIds = UUID(uuidString: "ab8f6b26-d135-4942-895b-5e5fcf259a60") {
//        viewModel.FetchEmptySchedule(vetId: vetIds, doctorId: doctorIds, appointmentDate: dates)
//    } else {
//        print("Invalid UUID or date format")
//    }
//}
