//
//  SettingsViewModel.swift
//  Weather App
//
//  Created by Ron Jurincie on 9/19/24.
//

import Foundation

@Observable
class SettingsViewModel {
    static var shared = SettingsViewModel()
    var isMetric = false
    var isCelcius = false
}

