//
//  HeaderComponent.swift
//  VetHere-ios-clone
//
//  Created by Andrew Oroh on 06/12/24.
//

import SwiftUI

struct PetHeaderComponent: View {
    var body: some View {
        VStack(alignment: .trailing){
            HStack(){
                Spacer()
                Text("Pets")
                    .font(.title)
                Spacer()
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .padding()
        }
    }
}

#Preview {
    PetHeaderComponent()
}
