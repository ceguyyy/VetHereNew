//
//  InformationView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct InformationViewComponent: View {
    let vetDetail: vet_detail
    
    var body: some View {
        VStack {
            MapAndAddressComponentView(
                lattitude: vetDetail.vet_lattitude, longitude: vetDetail.vet_longitude
            )
            .cornerRadius(10)
            .padding(.bottom)
            
            
            Text(vetDetail.vet_description)}
        VStack {
            HStack{
                if let facilities = vetDetail.facilities {
                    FacilitiesViewComponent(facilities: facilities)
                }
                Spacer()
        }
    
            
        }
    }
}

