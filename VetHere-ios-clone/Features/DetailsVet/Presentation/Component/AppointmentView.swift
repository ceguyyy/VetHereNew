//
//  AppointmentView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//
import SwiftUI

struct AppointmentView: View {
    let vetDetail: VetDetail
    let vetId: UUID
    let viewmodel: VetDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(vetDetail.doctor ?? [], id: \.id) { doctor in
                DoctorCardComponentView(
                    doctor: doctor,
                    bookingAction: {
                        viewmodel.goToDetails(
                            .goToBookChooseVet(
                                vetId: vetId, VetName: vetDetail.name, DoctorName: doctor.name,
                                DoctorId: doctor.id))
                    },
                    chatAction: {
                        viewmodel.goToDetails(
                            .openWhatApp(
                                vetDoctorName: doctor.name, vetPhoneNumber: vetDetail.phoneNumber))
                    }
                )
            }
        }
    }
}

