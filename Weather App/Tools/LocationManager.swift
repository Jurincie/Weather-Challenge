//
//  LocationManager 2.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import CoreLocation

class LocationManager {
    let geocoder = CLGeocoder()
    var cityName = ""
    let manager = CLLocationManager()
    var location: CLLocation?
    
    init(currentLocation: CLLocation? = nil) {
        self.location = currentLocation
        requestLocationPermission()
        getCurrentLocation()
        print(currentLocation.debugDescription)
    }
    
    func requestLocationPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() {
        manager.startUpdatingLocation()
        location = manager.location
    }
    
    func reverseGeocoding(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location,
                                        completionHandler: {[weak self] (placemarks, error) -> Void in
            guard let placemark = placemarks?.first,
                  placemark.locality != nil else { return }
            self?.cityName = placemark.locality!
        })
    }
}
