//
//  LocationManager.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import CoreLocation
import Foundation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
}
