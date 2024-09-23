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
    @State var showSearchSheet = false
    let viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.blue
            VStack(alignment: .leading) {
                if viewModel.loading {
                    ProgressView()
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                } else {
                    NavigationStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(String(viewModel.weatherInfo?.name ?? ""))
                                    .font(.largeTitle)
                            }
                        }
                        Text(Date.now, format: .dateTime.day().month().year().hour().minute())
                            .font(.caption)
                        Spacer()
                        WeatherView(viewModel: viewModel)
                        Spacer()
                    }
                    .navigationTitle("Weather")
                    .padding()
                }
            }
            .sheet(isPresented: $showSearchSheet) {
                SearchView(viewmodel: viewModel,
                           locationSearchService: locationSearchService)
                .presentationBackground(.thinMaterial)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        appCoordinator.push(.settingsView)
                    }) {
                        Text("Settings")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSearchSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
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


#Preview {
    MainView(locationSearchService: LocationSearchService())
}
