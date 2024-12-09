//
//  LoadingView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
    }
}

#Preview {
    LoadingView()
}
