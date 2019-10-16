//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    //TODO: Add random image using pixabay API
    //TODO: Add savebutton in navigation bar
    
    // MARK: - UI Lazy Objects
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = """
                        Weather Forecast for \(locationName!)
                        on \(selectedForecast.formattedDate)
                        """
        
        return label
    }()
    
    lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = selectedForecast.summary
        label.numberOfLines = 0
        return label
    }()
    
    lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "High: \(selectedForecast.temperatureHigh) °F"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Low: \(selectedForecast.temperatureLow) °F"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Sunrise: \(selectedForecast.formattedSunriseTime)"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Sunset: \(selectedForecast.formattedSunsetTime)"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Wind Speed: \(selectedForecast.windSpeed) mph"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var precipChanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Chance of Precipitation: \(selectedForecast.precipProbability*100)%"
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [highTempLabel, lowTempLabel, sunriseLabel, sunsetLabel, windSpeedLabel, precipChanceLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
//    lazy var saveFavoriteButton: UIBarButtonItem = {
//        let barButton = UIBarButtonItem(barButtonSystemItem: UIButton, target: self, action: <#T##Selector?#>)
//    }()
    
    // MARK: - Private Properties
    
    var selectedForecast: Forecast!
    var locationName: String!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        //TODO: Figure out why title doesn't appear
        self.navigationController?.title = "Forecast"
        
        addSubviews()
        addConstraints()
    }
    
    // MARK: UI Object Constraints
    private func addSubviews() {
        view.addSubview(locationLabel)
        view.addSubview(locationImageView)
        view.addSubview(currentWeatherLabel)
        view.addSubview(labelStackView)
    }
    
    private func addConstraints() {
        setLocationLabelConstraints()
        setLocationIamgeViewConstraints()
        setCurrentWeatherLabelConstraints()
        setLabelStackViewConstraints()
    }
    
    private func setLocationLabelConstraints() {
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.locationLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.locationLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.locationLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.locationLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setLocationIamgeViewConstraints() {
        self.locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.locationImageView.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 5),
            self.locationImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.locationImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.locationImageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func setCurrentWeatherLabelConstraints() {
        self.currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currentWeatherLabel.topAnchor.constraint(equalTo: self.locationImageView.bottomAnchor, constant: 5),
            self.currentWeatherLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.currentWeatherLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.currentWeatherLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setLabelStackViewConstraints() {
        self.labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.labelStackView.topAnchor.constraint(equalTo: self.currentWeatherLabel.bottomAnchor, constant: 5),
            self.labelStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            self.labelStackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            self.labelStackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

}
