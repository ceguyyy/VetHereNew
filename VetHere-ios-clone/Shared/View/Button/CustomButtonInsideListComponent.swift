//
//  CustomButton.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//


import SwiftUI

struct CustomButtonInsideListComponent: View {
    let title: String
    let action: () -> Void
    let isDisabled: Bool
    let backgroundColor: Color
    let textColor: Color
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .cornerRadius(8)
        }
        .foregroundColor(isDisabled ? .gray : textColor)
        .disabled(isDisabled)
        .animation(.easeInOut, value: isDisabled)
    }
}

#Preview {
    CustomButtonInsideListComponent(title: "Tittle", action: {
        print("Tap") }
    , isDisabled: true, backgroundColor: .black, textColor: .accentColor)
}
