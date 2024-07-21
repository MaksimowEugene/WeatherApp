//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Eugene Maksimow on 20.07.2024.
//

import UIKit

final class WeatherViewModel {
    private(set) var currentWeather: WeatherType
    
    init() {
        self.currentWeather = WeatherType.allCases.randomElement()!
    }
}

extension WeatherViewModel: WeatherViewModelProtocol {
    
    func setWeather(_ weather: WeatherType) {
        currentWeather = weather
    }
}
