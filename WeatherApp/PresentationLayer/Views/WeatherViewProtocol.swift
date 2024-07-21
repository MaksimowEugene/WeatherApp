//
//  WeatherViewProtocol.swift
//  WeatherApp
//
//  Created by Eugene Maksimow on 21.07.2024.
//

import UIKit

protocol WeatherViewProtocol: UIView {
    func updateWeather(with iconName: String)
    func animateWeather()
}
