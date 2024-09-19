//
//  ContentView.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import SwiftUI

struct MainView: View {
    @Environment(AppCoordinator.self) var appCoordinator
    var viewModel = ViewModel()
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.weatherInfo?.main?.temp != nil {
                    HStack {
                        let temperature = appCoordinator.isCelcius ? viewModel.kelvinToCelcius((viewModel.weatherInfo?.main?.temp)!) : viewModel.kelvinToFahrenheit((viewModel.weatherInfo?.main?.temp)!)
                        Text("Current Temp: ")
                        if let str = formatter.string(for: temperature) {
                            Text(str)
                            Text(appCoordinator.isCelcius ? "°C" : "°F")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        appCoordinator.push(.settingsView)
                    } label: {
                        Text("Settings")
                    }
                }
            }
            .navigationTitle("Weather")
            .padding()
        }
    }
}

//#Preview {
//    MainView()
//}
