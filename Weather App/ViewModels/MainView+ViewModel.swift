//
//  ViewModel+MainViewExtension.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import Foundation
import CoreLocation
import SwiftUI

extension MainView {
    @Observable
    class ViewModel {
        let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            return formatter
        }()
        let locationManager = LocationManager.shared
        var showErrorAlert = false
        var settingsViewModel = SettingsViewModel.shared
        var weatherInfo: WeatherInfo?
        private var imageCache = Cache<WeatherImage>(maxElements: 10)
        init() {
            Task {
                try await loadWeather()
                print(locationManager.weatherQueryString)
            }
        }
        
        func loadWeather() async throws {
            if let location = locationManager.manager.location {
                locationManager.setWeatherQueryFromReverseGeoLocation(location: location)
            }
        }
        
        func getImage(from imageName: String) -> Image? {
            guard imageCache.elements.count > 0 else { return nil }
            var newImage: Image? = nil
            
            // get new image
            if let weatherImage = imageCache.elements.first(where: { image in
                image.id == imageName
            }) {
                newImage = weatherImage.image
            } else {
                newImage = ApiService.fetchWeatherImage(name: imageName)
            }
            
            if let image = newImage {
                if imageCache.elements.count == imageCache.maxElements {
                    imageCache.elements.removeLast()
                }
                
                let weatherImage = WeatherImage(named: imageName,
                                                image: image)
                
                imageCache.elements.insert(weatherImage, at: 0)
            }
            
            return newImage
        }
    }
}
