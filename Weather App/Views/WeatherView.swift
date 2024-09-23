//
//  WeatherView.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/22/24.
//

import SwiftUI

struct WeatherView: View {
    var viewModel: MainView.ViewModel
    
    var body: some View {
        VStack {
            Text("Current Weather")
            VStack(alignment: .leading) {
                if let iconName = viewModel.weatherInfo?.weather?[0].icon {
                    let queryString = viewModel.locationManager.weatherIconQueryPrefix + iconName + viewModel.locationManager.weatherIconQuerySuffix
                    AsyncImage(url: URL(string: queryString))
                    .frame(width: 50, height: 50)
                }
                if viewModel.weatherInfo?.main?.temp != nil {
                    HStack {
                        Image(systemName: "thermometer")
                        let temperature = viewModel.settingsViewModel.isCelcius ? kelvinToCelcius((viewModel.weatherInfo?.main?.temp)!) : kelvinToFahrenheit(
                            (viewModel.weatherInfo?.main?.temp)!
                        )
                        if let str = viewModel.formatter.string(
                            for: temperature
                        ) {
                            Text(str)
                                .font(.largeTitle)
                            Text(
                                viewModel.settingsViewModel.isCelcius ? "°C" : "°F"
                            )
                        }
                    }
                }
                if viewModel.weatherInfo?.wind?.speed != nil {
                    HStack {
                        if let windSpeed = viewModel.weatherInfo?.wind?.speed {
                            let adjustedWindSpeed =  viewModel.settingsViewModel.isMetric ? mpsToKph(windSpeed) : mpsToMph(
                                windSpeed
                            )
                            Image(systemName: "wind")
                            if let str = viewModel.formatter.string(
                                for: adjustedWindSpeed
                            ) {
                                Text(str)
                                Text(viewModel.settingsViewModel.isMetric ? "KPH" : "MPH")
                            }
                            if let degrees = viewModel.weatherInfo?.wind?.deg {
                                getSysImage(degrees)
                            }
                        }
                    }
                }
                if viewModel.weatherInfo?.main?.humidity != nil {
                    HStack {
                        Text("Humidity:")
                        Text("\(viewModel.weatherInfo?.main?.humidity ?? 0)°")
                    }
                }
            }
            .font(.caption)
            .padding()
            .border(.primary, width: 2)
        }
    }
}

#Preview {
    WeatherView(viewModel: MainView.ViewModel())
}

func getSysImage(_ degrees: Int) -> Image {
    switch degrees {
    case 0..<22:
        return Image(systemName: "arrow.down")
    case 22..<67:
        return Image(systemName: "arrow.down.left")
    case 67..<112:
        return Image(systemName: "arrow.left")
    case 112..<157:
        return Image(systemName: "arrow.up.left")
    case 157..<202:
        return Image(systemName: "arrow.up")
    case 202..<247:
        return Image(systemName: "arrow.up.right")
    case 247..<302:
        return Image(systemName: "arrow.right")
    case 302..<347:
        return Image(systemName: "arrow.down.right")
    default:
        return Image(systemName: "arrow.up.right")
    }
}
