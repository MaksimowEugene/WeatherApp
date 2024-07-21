//
//  WeatherViewModelProtocol.swift
//  WeatherApp
//
//  Created by Eugene Maksimow on 21.07.2024.
//

import Foundation

protocol WeatherViewModelProtocol {
    var currentWeather: WeatherType { get }
    func setWeather(_ weather: WeatherType)
}
