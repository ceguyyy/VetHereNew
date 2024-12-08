//
//  NoteView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct ChooseScheduleView: View {
    @StateObject private var viewModel: ChooseScheduleViewModel
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    
    init(_ coordinator: any AppCoordinatorProtocol) {
        self._viewModel = StateObject(wrappedValue: ChooseScheduleViewModel(coordinator))
    }
    var body: some View {
        VStack{
            Text("emptySchedule") .onTapGesture {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                if let dates = dateFormatter.date(from: "2024-12-12"),
                   let vetIds = UUID(uuidString: "2898f694-7447-473c-b936-a269cfea6ffe"),
                   let doctorIds = UUID(uuidString: "ab8f6b26-d135-4942-895b-5e5fcf259a60") {
                    viewModel.FetchEmptySchedule(vetId: vetIds, doctorId: doctorIds, appointmentDate: dates)
                } else {
                    print("Invalid UUID or date format")
                }
            }
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
                CustomButtonComponent(title: "Lanjutkan", action: { print(
                    "Tap Schedule")
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

#Preview {
  @Previewable
  @StateObject var appCoordinator = AppCoordinator()
  NavigationStack(path: $appCoordinator.path) {
      ChooseScheduleView(appCoordinator)
      .navigationDestination(for: Screen.self) { screen in
        appCoordinator.build(screen)
      }
  }
}
