//
//  DoctorCardComponentView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import SwiftUI

struct DoctorCardViewComponent: View {
  var doctor: doctors
  var bookingAction: () -> Void
  var chatAction: () -> Void

    var body: some View {
        if doctor.doctor_name == "NoDoctor"{
            HStack(){
                Spacer()
                Text("No Doctor Available").foregroundColor(.gray).font(.caption)
                Spacer()
            }
          
        } else{
            VStack(alignment: .leading) {
                HStack() {
                    if let imageURL = URL(string: doctor.doctor_image ?? Constant.ErrorImage) {
                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .frame(width: 88, height: 88)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 88, height: 88)
                        }
                    } else if let imageURL = URL(string: Constant.ErrorImage) {
                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .frame(width: 88, height: 88)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 8, height: 88)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(doctor.doctor_name)
                            .font(.headline)
                            .bold()
                            .padding(.leading)
                        Text(doctor.specialization.specialization_name)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.leading)
                        HStack {
                            ForEach(0..<doctor.doctor_rating, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                            }
                        }.padding(.leading)
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            chatAction()
                        }) {
                            Text("Chat").font(.caption2)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .foregroundColor(Color("AppPrimary"))
                        .background(Color("AppOrange"))
                        .cornerRadius(10)
                        
                        Button(action: {
                            bookingAction()
                        }) {
                            Text("Pesan").font(.caption2)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .foregroundColor(Color("AppPrimary"))
                        .background(Color("AppOrange"))
                        .cornerRadius(10)
                        
                    }
                    .padding(.horizontal)
                }
                .foregroundColor(Color("AppPrimary"))
                .background(Color("AppSecondary"))
            }
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
}

#Preview {
    DoctorCardViewComponent(doctor: DoctorModel(id: UUID(), name: "UCOK", rating: 5, specialization: SpecializationModel(id: UUID(), name: "Ahli"), image: Constant.ErrorImage), bookingAction: {
        print("Booked")
    }, chatAction: {
        print("Chat")
    })
}
