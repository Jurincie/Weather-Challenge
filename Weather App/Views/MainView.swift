//
//  ContentView.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import SwiftUI

struct MainView: View {
    @Environment(AppCoordinator.self) var appCoordinator
    @State var locationSearchService: LocationSearchService
    let viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background
                Color.blue
                // foreground
                VStack {
//                    VStack {
//                        SearchBar(text: $locationSearchService.searchQuery)
//                        List(locationSearchService.completions) { completion in
//                            VStack(alignment: .leading) {
//                                Text(completion.title)
//                                Text(completion.subtitle)
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                            }
//                        }.navigationBarTitle(Text("Search near me"))
//                    }
                
                   Spacer()
                    Image(.launch)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height:200)
                    let str = String(viewModel.weatherInfo?.name ?? "")
                    Text("Location: " + str)
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        if viewModel.weatherInfo?.main?.temp != nil {
                            HStack {
                                let temperature = viewModel.settingsViewModel.isCelcius ? kelvinToCelcius((viewModel.weatherInfo?.main?.temp)!) : kelvinToFahrenheit(
                                    (viewModel.weatherInfo?.main?.temp)!
                                )
                                Text("Current Temp:")
                                if let str = viewModel.formatter.string(
                                    for: temperature
                                ) {
                                    Text(str)
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
                                    Text("Wind Speed:")
                                    if let str = viewModel.formatter.string(
                                        for: adjustedWindSpeed
                                    ) {
                                        Text(str)
                                        Text(
                                            viewModel.settingsViewModel.isMetric ? "KPH" : "MPH"
                                        )
                                    }
                                }
                            }
                            HStack {
                                Text("Wind Direction:")
                                let string = String(
                                    (viewModel.weatherInfo?.wind?.deg)!
                                )
                                Text(string + "°")
                            }
                        }
                    }
                    .task {
                        do {
                            do {
                                viewModel.weatherInfo = try await ApiService.fetch(from: viewModel.locationManager.weatherQueryString)
                            } catch {
                                viewModel.showErrorAlert = true
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                appCoordinator.push(.settingsView)
                            }) {
                                Text("Settings")
                            }
                        }
                    }
                    .navigationTitle("Weather")
                    .padding()
                    .border(.primary, width: 2)
                    Spacer()
                }
            }
            .alert("API Error",
                   isPresented: Bindable(viewModel).showErrorAlert) {
                Button("OK", role: .cancel) {
                    fatalError()
                }
            }
        }
    }
}

//#Preview {
//    MainView()
//}
