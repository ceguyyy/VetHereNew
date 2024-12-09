//
//  MapAnnotationView.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 30/10/24.
//


import SwiftUI
import MapKit

struct MapAnnotationComponentView: View {
    let annotation: VetAnnotationModel
    let action: () -> Void
    var body: some View {
        VStack {
            Image(systemName: "mappin")
                .resizable()
                .frame(width: 15, height: 40)
                .foregroundColor(.blue)
                .onTapGesture {
                    action()
                }
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationComponentView(annotation: VetAnnotationModel(latitude: 37.7749, longitude: -122.4194), action: {
            print("Map pin tapped")
        })
    }
}
