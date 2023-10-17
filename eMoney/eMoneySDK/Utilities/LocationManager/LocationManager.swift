//
//  LocationManager.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 29/07/2023.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    // Create a CLLocationManager instance
    private let locationManager = CLLocationManager()
    
    // Define a delegate to receive location updates
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        
        // Set the delegate to this class
        locationManager.delegate = self
        
        // Set the desired accuracy for location updates (you can choose the appropriate accuracy level based on your needs)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        
        // Request user authorization for location services
        locationManager.requestWhenInUseAuthorization()
        
        // Start monitoring location updates
        locationManager.startUpdatingLocation()
    }
    
    // Function to check if location services are enabled
    func isLocationEnabled() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .authorizedWhenInUse || status == .authorizedAlways
    }
    
    func currentLocationStatus() -> CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }
    
    // Start Updating Location
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    // Stop updating Location
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        delegate?.locationManager(didChangeAuthorization: CLLocationManager.authorizationStatus())
    }
    
    // This method is called when the location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // Notify the delegate about the updated location
            delegate?.locationManager(didUpdateLocation: location)
        }
    }
    
    // This method is called if there is an error retrieving the location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Notify the delegate about the error
        delegate?.locationManager(didFailWithError: error)
    }
}

// Delegate protocol to handle location updates
protocol LocationManagerDelegate: AnyObject {
    func locationManager(didUpdateLocation location: CLLocation)
    func locationManager(didChangeAuthorization status: CLAuthorizationStatus)
    func locationManager(didFailWithError error: Error)
}

extension LocationManagerDelegate {
    func locationManager(didUpdateLocation location: CLLocation) {}
    func locationManager(didChangeAuthorization status: CLAuthorizationStatus) {}
    func locationManager(didFailWithError error: Error) {}
}
