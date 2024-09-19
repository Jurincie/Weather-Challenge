//
//  ViewModel+MainViewExtension.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import Foundation
import SwiftUI

extension MainView {
    
    @Observable
    class ViewModel {
        let maxImages = 10
        private let iconEndPoint = "https://openweathermap.org/img/wn/10d@2x.png"
        let weatherApiKey = "b3660824db9ee07a39128f01914989bc"
        let cityQueryPrefix = "https://api.openweathermap.org/data/2.5/weather?q="
        private let weatherImageQueryPrefix = ""
        private let geoLocationQueryPrefix = ""
        private(set) var locationName = "Dallas"
        var weatherInfo: WeatherInfo?
        private var imageCache = [WeatherImage]()
        
        init(weatherInfo: WeatherInfo? = nil,
             imageCache: [WeatherImage] = [WeatherImage]()) {
            self.weatherInfo = weatherInfo
            self.imageCache = imageCache
            let queryEndpoint = cityQueryPrefix + locationName + "&appid=" + weatherApiKey
            Task {
                do {
                    self.weatherInfo = try await ApiService.fetch(from: queryEndpoint)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        func kelvinToCelcius(_ input: Double) -> Double {
            return input - 273.15
        }
        
        func kelvinToFahrenheit(_ input: Double) -> Double {
            (input - 273.15) * 1.8 + 32
        }
        
        func getImage(from imageName: String) -> Image? {
            guard imageCache.count > 0 else { return nil }
            var newImage: Image? = nil
            
            // get new image
            if let image = imageCache.first(where: { image in
                image.id == imageName
            }) {
                newImage = image.image
            } else {
                newImage = ApiService.fetchWeatherImage(name: imageName)
            }
            
            if let image = newImage {
                if imageCache.count == maxImages {
                    imageCache.removeLast()
                }
                
                let weatherImage = WeatherImage(named: imageName,
                                                image: image)
                
                imageCache.insert(weatherImage, at: 0)
            }
            
            return newImage
        }
    }
}
