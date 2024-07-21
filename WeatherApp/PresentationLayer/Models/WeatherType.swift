//
//  WeatherType.swift
//  WeatherApp
//
//  Created by Eugene Maksimow on 20.07.2024.
//

import Foundation

enum WeatherType: String, CaseIterable {
    
    case clear = "sun.max"
    case rain = "cloud.rain"
    case thunderstorm = "cloud.bolt.rain"
    case fog = "cloud.fog"
    case snow = "snow"

    var displayName: String {
        switch self {
        case .clear:
            return NSLocalizedString("Clear", comment: "Clear weather")
        case .rain:
            return NSLocalizedString("Rain", comment: "Rain weather")
        case .thunderstorm:
            return NSLocalizedString("Thunderstorm", comment: "Thunderstorm weather")
        case .fog:
            return NSLocalizedString("Fog", comment: "Fog weather")
        case .snow:
            return NSLocalizedString("Snow", comment: "Snow weather")
        }
    }
}
