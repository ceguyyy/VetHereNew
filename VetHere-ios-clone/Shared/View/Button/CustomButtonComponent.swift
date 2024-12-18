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
    var foregroundColor: Color?
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .padding()
                .padding(.horizontal, 80)
                .background(backgroundColor)
                .foregroundColor(foregroundColor ?? .white)
                .cornerRadius(8)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonComponent(text: "Tambah Hewan", backgroundColor: .blue, action: {}, padding: 100, foregroundColor: .white)
    }
}
