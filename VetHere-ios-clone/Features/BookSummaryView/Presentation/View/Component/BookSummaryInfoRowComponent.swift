//
//  InfoRow.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//


import SwiftUI

struct BookSummaryInfoRowComponent: View {
    var label: String
    var value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.custom("SF Pro", size: 20).weight(.semibold))
                .foregroundColor(.black)
            Spacer()
            Text(value)
                .font(.custom("SF Pro", size: 20))
                .foregroundColor(.black)
        }
    }
}
