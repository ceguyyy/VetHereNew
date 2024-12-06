//
//  MapAndAddressView.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 30/10/24.
//

import SwiftUI

struct MapAndAddressComponentView: View {
    var lattitude: Double
    var longitude: Double
    
    var body: some View {
        VStack {
            MapComponentView(latitude: lattitude, longitude: longitude)
                .frame(width: 361, height: 200)
                .padding(.horizontal)
                .cornerRadius(10)
        }.cornerRadius(10)
    }
    }
