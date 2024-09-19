//
//  ApiService.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import Combine
import Foundation
import SwiftUI

/*
 https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
 https://api.openweathermap.org/data/2.5/weather?q={city name},{country code}&appid={API key}
 https://api.openweathermap.org/data/2.5/weather?q={city name},{state code},{country code}&appid={API key}

 https://api.openweathermap.org/data/2.5/weather?q=Dallas&appid=b3660824db9ee07a39128f01914989bc
 */

enum ApiError: Error {
    case badURL
    case decodingError
    case invalidResponse
    case unknownError
}

class ApiService {
    private var iconEndPoint = "https://openweathermap.org/img/wn/10d@2x.png"
    private let weatherApiKey = "b3660824db9ee07a39128f01914989bc"
    private let cityQueryPrefix = "https://api.openweathermap.org/data/2.5/weather?q="
    private let weatherImageQueryPrefix = ""
    private let geoLocationQueryPrefix = ""
    private var cancellables = Set<AnyCancellable>()
    private(set) var cityName = "Dallas"
    var shared = ApiService()
    
    var weatherData: WeatherInfo?
    
    init() {
        do {
            let endpoint = cityQueryPrefix + cityName + "&appid=" + weatherApiKey
            try fetchWeather(from: endpoint)
        } catch {
            print("Downloading Error")
            fatalError()
        }
    }
    
    func fetchWeather(from urlString: String) throws {
        guard let url = URL(string: urlString) else { throw ApiError.badURL }
        
        // This line creates a publisher that initiates a URL session data task for the specified URL.
        // The publisher emits the data and URL response upon successful completion of the request.
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: WeatherInfo.self, decoder: JSONDecoder())
            .sink { completion in
                print("COMPLETION: \(completion)")
                // and another for handling the received values
            } receiveValue: { [weak self]  weather in
                guard let self = self else { return }
                self.weatherData = weather
            }
            // prevents from being deallocated before completion.
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              200...299 ~= response.statusCode else {
            throw ApiError.invalidResponse
        }
        return output.data
    }
    
    func fetchWeatherImage(name:String) -> Image? {
        return nil
    }
}
