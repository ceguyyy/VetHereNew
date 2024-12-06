//
//  MapView.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 30/10/24.
//
import SwiftUI
import MapKit

struct MapComponentView: View {
    @StateObject private var viewModel: MapViewModel

    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        _viewModel = StateObject(wrappedValue: MapViewModel(latitude: latitude, longitude: longitude))
    }

    var body: some View {
        Map(coordinateRegion: $viewModel.region, interactionModes: .zoom, showsUserLocation: true, annotationItems: viewModel.annotations) { annotation in
            MapAnnotation(coordinate: annotation.coordinate) {
                MapAnnotationComponentView(annotation: annotation, action: {
                    viewModel.openInMaps(latitude: annotation.latitude, longitude: annotation.longitude)
                })
            }
        }
        .onAppear {
            viewModel.updateRegion(latitude: viewModel.region.center.latitude, longitude: viewModel.region.center.longitude)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MapComponent_Previews: PreviewProvider {
    static var previews: some View {
        MapComponentView(latitude: 37.7749, longitude: -122.4194)
            .previewDevice("iPhone 14")
    }
}
