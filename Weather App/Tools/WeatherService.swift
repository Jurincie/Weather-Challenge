//
//  WeatherService.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/20/24.
//

import CoreLocation
import Foundation

public final class WeatherService: NSObject {
    private let iconEndPoint = "https://openweathermap.org/img/wn/10d@2x.png"
    let weatherApi_KEY = "b3660824db9ee07a39128f01914989bc"
    let weatherQuery = "https://api.openweathermap.org/data/2.5/weather?q="
    private let weatherImageQueryPrefix = ""
    private let geoLocationQueryPrefix = ""
    private(set) var locationName = "Pittsford,.as"
 
}
