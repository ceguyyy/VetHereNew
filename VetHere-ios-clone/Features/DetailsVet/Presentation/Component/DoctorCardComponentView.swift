//
//  DoctorCardComponentView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import SwiftUI

struct DoctorCardComponentView: View {
  var doctor: Doctor
  var bookingAction: () -> Void
  var chatAction: () -> Void

    var body: some View {
        if doctor.name == "NoDoctor"{
            HStack(){
                Spacer()
                Text("No Doctor Available").foregroundColor(.gray).font(.caption)
                Spacer()
            }
          
        } else{
            VStack(alignment: .leading) {
                HStack() {
                    if let imageURL = URL(string: doctor.image ?? Constant.ErrorImage) {
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
                        Text(doctor.name)
                            .font(.headline)
                            .bold()
                            .padding(.leading)
                        Text(doctor.specialization.name)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.leading)
                        HStack {
                            ForEach(0..<doctor.rating, id: \.self) { _ in
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
                        .foregroundColor(Color("TextColor"))
                        .background(Color("ColorCard"))
                        .cornerRadius(10)
                        
                        Button(action: {
                            bookingAction()
                        }) {
                            Text("Pesan").font(.caption2)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .foregroundColor(Color("TextColor"))
                        .background(Color("ColorCard"))
                        .cornerRadius(10)
                        
                    }
                    .padding(.horizontal)
                }
                .foregroundColor(Color("TextColor"))
                .background(Color("DoctorCard"))
            }
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
}
