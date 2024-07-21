//
//  WeatherSelectorView.swift
//  WeatherApp
//
//  Created by Eugene Maksimow on 21.07.2024.
//

import UIKit

private struct Constants {
    static let collectionViewItemSize = CGSize(width: 100, height: 100)
    static let collectionViewItemSpacing: CGFloat = 10
    static let collectionViewCornerRadius: CGFloat = 10
    static let currentWeatherViewCornerRadius: CGFloat = 20
    static let weatherCellReuseIdentifier = "weatherCell"
    static let borderWidth: CGFloat = 2.0
    static let labelFontSize: CGFloat = 14
    static let collectionViewHeight: CGFloat = 100
    static let collectionViewLeadingTrailingPadding: CGFloat = 10
    static let currentWeatherViewTopPadding: CGFloat = 10
    static let selectedCellBackgroundColorAlpha: CGFloat = 0.2
    static let transitionDuration: TimeInterval = 0.5
}


class WeatherSelectorView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let weatherViewModel: WeatherViewModelProtocol = WeatherViewModel()
    private var weatherCollectionView: UICollectionView!
    private var currentWeatherView: WeatherView!
    private var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupCurrentWeatherView()
        selectRandomWeather()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Constants.collectionViewItemSpacing
        layout.minimumLineSpacing = Constants.collectionViewItemSpacing
        layout.itemSize = Constants.collectionViewItemSize
      
        weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.weatherCellReuseIdentifier)
        weatherCollectionView.showsHorizontalScrollIndicator = false
        weatherCollectionView.layer.cornerRadius = Constants.collectionViewCornerRadius
        view.addSubview(weatherCollectionView)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.collectionViewLeadingTrailingPadding),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.collectionViewLeadingTrailingPadding),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: Constants.collectionViewHeight)
        ])
    }
    
    private func setupCurrentWeatherView() {
        currentWeatherView = WeatherView(frame: .zero)
        currentWeatherView.layer.cornerRadius = Constants.currentWeatherViewCornerRadius
        currentWeatherView.layer.masksToBounds = true
        view.addSubview(currentWeatherView)
        currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentWeatherView.topAnchor.constraint(equalTo: weatherCollectionView.bottomAnchor, constant: Constants.currentWeatherViewTopPadding),
            currentWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentWeatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func selectRandomWeather() {
        let randomIndex = Int.random(in: 0..<WeatherType.allCases.count)
        selectedIndexPath = IndexPath(row: randomIndex, section: 0)
        let selectedWeather = WeatherType.allCases[randomIndex]
        weatherViewModel.setWeather(selectedWeather)
        
        updateWeatherView()
        weatherCollectionView.reloadData()
    }
    
    private func updateWeatherView() {
        let iconName = weatherViewModel.currentWeather.rawValue
        currentWeatherView.updateWeather(with: iconName)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.weatherCellReuseIdentifier, for: indexPath)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let weatherType = WeatherType.allCases[indexPath.row]
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.borderWidth = Constants.borderWidth
        cell.layer.cornerRadius = Constants.collectionViewCornerRadius
        cell.layer.masksToBounds = true
        
        let label = UILabel()
        label.text = weatherType.displayName
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize)
        cell.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        if indexPath == selectedIndexPath {
            cell.contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(Constants.selectedCellBackgroundColorAlpha)
        } else {
            cell.contentView.backgroundColor = .systemBackground
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWeather = WeatherType.allCases[indexPath.row]
        weatherViewModel.setWeather(selectedWeather)
        selectedIndexPath = indexPath
        
        UIView.transition(with: currentWeatherView, duration: Constants.transitionDuration, options: .transitionCrossDissolve, animations: {
            self.updateWeatherView()
        }, completion: nil)
        
        collectionView.reloadData()
    }
}
