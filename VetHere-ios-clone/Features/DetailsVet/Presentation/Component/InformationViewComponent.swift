//
//  InformationView.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 06/12/24.
//

import SwiftUI

struct InformationViewComponent: View {
    let vetDetail: VetDetail
    
    var body: some View {
        VStack {
            MapAndAddressComponentView(
                lattitude: vetDetail.lattitude, longitude: vetDetail.longitude
            )
            .cornerRadius(10)
            .padding(.bottom)
            
            
            Text(vetDetail.description)}
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

