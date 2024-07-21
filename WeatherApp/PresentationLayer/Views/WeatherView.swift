//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Eugene Maksimow on 20.07.2024.
//

import UIKit

private struct Constants {
    static let imageViewCornerRadius: CGFloat = 20
    static let imageViewAnimationDuration: TimeInterval = 1.0
}


final class WeatherView: UIView {
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}


extension WeatherView: WeatherViewProtocol {
    
    func updateWeather(with iconName: String) {
        if let image = UIImage(systemName: iconName) {
            imageView.image = image
            imageView.tintColor = .label
            animateWeather()
        }
    }
    
    internal func animateWeather() {
        imageView.alpha = 0
        UIView.animate(withDuration: Constants.imageViewAnimationDuration) {
            self.imageView.alpha = 1
        }
    }
}
