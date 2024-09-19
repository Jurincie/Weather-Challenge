//
//  ListViewModel.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import Foundation
import SwiftUI

struct WeatherImage: Identifiable {
    let id: String
    let image: Image
    
    init(named id: String, image: Image) {
        self.id = id
        self.image = image
    }
}

class MainViewModel {
    let apiService = ApiService()
    let maxImages = 10
    private var imageCache = [WeatherImage]()
    
    
    func getImage(from imageName: String) -> Image? {
        guard imageCache.count > 0 else { return nil }
        var newImage: Image? = nil
        
        // get new image
        if let image = imageCache.first(where: { image in
            image.id == imageName
        }) {
            newImage = image.image
        } else {
            newImage = apiService.fetchWeatherImage(name: imageName)
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
