//
//  MapViewModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 14/11/24.
//



import Foundation
import MapKit

class MapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var annotations: [VetAnnotationModel]

    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
        self.annotations = [VetAnnotationModel(latitude: latitude, longitude: longitude)]
    }

    func updateRegion(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    func openInMaps(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let coordinate = "\(latitude),\(longitude)"
        let urlString = "http://maps.apple.com/?q=\(coordinate)"

        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
