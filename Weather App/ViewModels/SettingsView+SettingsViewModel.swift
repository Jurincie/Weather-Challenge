//
//  SettingsViewExtension+SettingsViewModel.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import Foundation

extension SettingsView {
    @Observable
    class ViewModel {
        var isMetric = false
        var isCelcius = false
    }
}

