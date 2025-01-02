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
    @State private var selectedTime: String = ""
    
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
        NavigationView {
            VStack {
                List {
                    Section {
                        VStack {
                            DatePicker(
                                "Select a date and time",
                                selection: $selectedDate,
                                in: Date()...,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                            
                            if viewModel.schedules.isEmpty {
                                Text("No schedule available")
                                    .foregroundColor(.red)
                                    .padding()
                            } else {
                                Picker("Select Time", selection: $selectedTime) {
                                    ForEach(viewModel.schedules, id: \.self) { time in
                                        Text(time)
                                    }
                                }
                                .padding()
                            }

 
                        }
                    }
                }
                
                VStack(spacing: 20) {
        
                    
                    CustomButtonInsideListComponent(title: "Lanjutkan", action: {
                    
                        if let combinedDate = convertTimeToDate(timeString: selectedTime) {
                            print("Combined Date: \(combinedDate)")
                            
                            viewModel.goToDetails(.goToBookNotes(
                                vetId: vetId,
                                VetName: vetName,
                                DoctorName: doctorName,
                                DoctorId: doctorId,
                                PetId: petId,
                                PetName: petName,
                                appointmentDate: selectedDate,
                                appointmentTime: combinedDate 
                            ))
                        } else {
                            print("Invalid time format")
                        }
                     

                    }, isDisabled: false, backgroundColor: Color("AppOrange"), textColor: .white)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
            .onAppear {
                viewModel.onInput(.didFetchEmptySchedule, vetId: vetId, doctorId: doctorId, appointmentDate: selectedDate)
            }
            .background(Color(.systemGray6))
            .navigationTitle("Pilih Jadwal")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
