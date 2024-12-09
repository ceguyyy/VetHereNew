//
//  CustomButton.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 09/12/24.
//


import SwiftUI

struct CustomButtonComponent: View {
    var text: String
    var backgroundColor: Color
    var action: () -> Void
    var padding: CGFloat
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal, 80)
                .background(backgroundColor)
                .cornerRadius(8)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonComponent(text: "Tambah Hewan", backgroundColor: .blue, action: {}, padding: 100)
    }
}
