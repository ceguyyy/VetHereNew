//
//  AppointmentView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//
import SwiftUI

struct AppointmentViewComponent: View {
    let vetDetail: vet_detail
    let vetId: UUID
    let viewmodel: VetDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(vetDetail.vet_doctors ?? [], id: \.doctor_id) { doctor in
                DoctorCardViewComponent(
                    doctor: doctor,
                    bookingAction: {
                        viewmodel.goToDetails(
                            .goToBookChooseVet(
                                vetId: vetId, VetName: vetDetail.vet_name, DoctorName: doctor.doctor_name,
                                DoctorId: doctor.doctor_id))
                    },
                    chatAction: {
                        viewmodel.goToDetails(
                            .openWhatApp(
                                vetDoctorName: doctor.doctor_name, vetPhoneNumber: vetDetail.vet_phone_number))
                    }
                )
            }
        }
    }
}

