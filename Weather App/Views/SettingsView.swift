//
//  SettingsView.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AppCoordinator.self) var appCoordinator
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 4) {
                Spacer(minLength: 20)
                Toggle("Temp" , isOn: Bindable(appCoordinator).isCelcius)
                Text(appCoordinator.isCelcius ? "°C" : "°F")
                Spacer(minLength: 20)
            }
            HStack(spacing: 4) {
                Spacer(minLength: 20)
                Toggle("Wind Speed", isOn: Bindable(appCoordinator).isMetric)
                Text(appCoordinator.isMetric ? "KPH" : "MPH")
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
