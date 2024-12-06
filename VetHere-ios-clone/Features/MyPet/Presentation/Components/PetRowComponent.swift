//
//  PetRow.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import SwiftUI

struct PetRow: View {
    let imageUrl : String
    let petName : String
    let petType : String
    var body: some View {
        HStack{
            Image(.doctor)
                .resizable()
                .frame(width: 44, height: 44)
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .shadow(radius: 5)
            
            VStack(alignment: .leading){
                Text(petName)
                Text(petType)
                    .font(.footnote)
            }
            .padding()
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.chevron)
        }
        .padding()
    }
}

#Preview {
    PetRow(imageUrl: "testurl", petName: "catto", petType: "test type")
}
