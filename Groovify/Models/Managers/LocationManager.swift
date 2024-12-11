//
//  LocationManager.swift
//  Groovify
//
//  Created by David Romero on 2024-12-11.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var locationError: String?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        requestLocationPermission()
    }

    func requestLocationPermission() {
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            print("Location Authorization Status: \(status.rawValue)")
            
            switch status {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                locationError = "Location access is restricted or denied. Using default coordinates."
                setDefaultLocation()
            case .authorizedAlways, .authorizedWhenInUse:
                manager.startUpdatingLocation()
            @unknown default:
                locationError = "Unknown location authorization status."
                setDefaultLocation()
            }
        } else {
            locationError = "Location services are disabled. Using default coordinates."
            setDefaultLocation()
        }
    }

   

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.locationError = "Failed to fetch location: \(error.localizedDescription). Using default coordinates."
            print("Location Manager Error: \(error.localizedDescription)")
            self.setDefaultLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
                self.locationError = nil  // Clear the error when location is successfully updated
                print("User Location Updated: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            }
        }
    }


    private func setDefaultLocation() {
        DispatchQueue.main.async {
            // Default to a known city (e.g., San Francisco)
            self.userLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        }
    }
}
