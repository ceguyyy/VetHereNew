//
//  LocationManager.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 02/12/24.
//


import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var locationError: Error?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func requestLocationPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            locationError = NSError(domain: "Location", code: 0, userInfo: [NSLocalizedDescriptionKey: "Location permission is denied or restricted."])
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }

  
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = error
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        locationManager.stopUpdatingLocation()
        
        print("Latitude updated: \(latitude ?? 0.0)")
        print("Longitude updated: \(longitude ?? 0.0)")
    }
}
