//
//  VetAnnotationModel.swift
//  VetHere-ios-clone
//
//  Created by Christian Gunawan on 05/12/24.
//

import Foundation
import CoreLocation

class VetAnnotationModel: Identifiable {
    var id: UUID = UUID()
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
