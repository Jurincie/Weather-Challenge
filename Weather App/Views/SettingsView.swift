//
//  SettingsView.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import SwiftUI

struct SettingsView: View {
    @State var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 4) {
                Spacer(minLength: 20)
                Toggle("Temp" , isOn: $settingsViewModel.isCentigrade)
                Text(settingsViewModel.isCentigrade ? "°C" : "°F")
                Spacer(minLength: 20)
            }
            HStack(spacing: 4) {
                Spacer(minLength: 20)
                Toggle("Wind Speed", isOn: $settingsViewModel.isMetric)
                Text(settingsViewModel.isMetric ? "KPH" : "MPH")
                Spacer(minLength: 20)
            }
        }
        .font(.caption)
        .bold()
        .padding()
        .border(.primary, width: 2)
        .padding()
    }
}

#Preview {
    SettingsView()
}
