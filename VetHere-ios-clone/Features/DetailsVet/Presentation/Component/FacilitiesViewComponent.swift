//
//  FacilitiesView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct FacilitiesViewComponent: View {
    let facilities: [FacilitiesModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Fasilitas:")
                .font(.headline)
                .fontWeight(.bold)
            VStack(alignment: .leading, spacing: 4) {
                ForEach(facilities, id: \.id) { facility in
                    Text("• \(facility.name)")
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding()
    }
}
