//
//  FailedBookView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 21/11/24.
//

import SwiftUI

struct SuccessBookView: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Text("Booking Berhasil")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 36)
            
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 134, height: 134)
                .scaleEffect(scale)
                .foregroundColor(Color.blue)
                .opacity(0.5)
                .onAppear {
                    withAnimation(
                        Animation.spring(duration: 1.0).repeatForever(autoreverses: true)
                    ) {
                        scale = 1.5
                    }
                }
            
                .padding(.top, 36)
                .overlay( Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 134, height: 134)
                    .padding(.top, 36))
                .overlay( Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(Color.blue)
                    .frame(width: 134, height: 134)
                    .padding(.top, 36))
          
            
              
            
            Spacer()
        }        .navigationTitle("Berhasil Pesan")
        .frame(width: 360, height: 360)
        .background(Color(.lightGray))
        .cornerRadius(10)
        
        VStack {
            HStack {
                Spacer()
                Text("Kembali kehalaman utama")
                Spacer()
            }
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .frame(maxWidth: .infinity)
            .cornerRadius(8)
            .padding()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SuccessBookView()
}
