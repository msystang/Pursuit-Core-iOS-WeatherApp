//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - UI Lazy Objects
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Enter ZipCode"
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        return textField
    }()
    
    
    lazy var weatherCollectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weatherCell")
        return collectionView
    }()
    
    // MARK: - Private Properties
    private var weather = [Forecast]() {
        didSet {
            self.weatherCollectionView.reloadData()
        }
    }
    
    private var searchString: String? {
        didSet {
            loadLatLongFromZip()
            loadData()
            self.weatherCollectionView.reloadData()
        }
    }

    private var latitude = String()
    private var longitude = String()
    private var locationName = String()
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        addSubviews()
        addConstraints()
    }

    // MARK: - Private Functions
    private func loadLatLongFromZip() {
        ZipCodeHelper.getLatLong(fromZipCode: searchString ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.latitude = String(data.lat)
                    self.longitude = String(data.long)
                    self.locationName = String(data.location)
                    self.loadData()
                    self.updateLocationLabel()
                }
            }
        }
    }
    
    private func loadData() {
        let urlStr = WeatherAPIClient.getSearchResultsURLStr(from: latitude, longitude: longitude)
        
        WeatherAPIClient.manager.getWeather(urlStr: urlStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        self.weather = data
                }
            }
        }
    }
    
    private func updateLocationLabel() {
        self.locationLabel.text = "Weekly Forecast for \(locationName)"
    }
    
    // MARK: UI Object Constraints
    private func addSubviews() {
        self.view.addSubview(locationLabel)
        self.view.addSubview(textField)
        self.view.addSubview(weatherCollectionView)
    }
    
    private func addConstraints() {
        setLocationLabelConstraints()
        setTextFieldConstraints()
        setCollectionViewConstraints()
    }
    
    private func setLocationLabelConstraints() {
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.locationLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.locationLabel.heightAnchor.constraint(equalToConstant: 50),
            self.locationLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.locationLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setTextFieldConstraints() {
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 5),
            self.textField.widthAnchor.constraint(equalToConstant: 100),
            self.textField.heightAnchor.constraint(equalToConstant: 30),
            self.textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setCollectionViewConstraints() {
        self.weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.weatherCollectionView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            self.weatherCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.weatherCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.weatherCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    

}

// MARK: - CollectionView Data Source & Delegate Methods
extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCollectionViewCell
        let dailyWeather = weather[indexPath.row]
        
        // TODO: Convert time to date format
        cell.dateLabel.text = String(dailyWeather.time)
        
        // TODO: Create func to find correct image
        cell.weatherImageView.image = UIImage(named: "clear")
        
        cell.highTempLabel.text = "High: \(dailyWeather.temperatureHigh) °F"
        cell.lowTempLabel.text = "Low: \(dailyWeather.temperatureLow) °F"
        
        return cell
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    // make flow horizontal
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
}

// MARK: - TextField Delegate Methods
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchString = textField.text
        return true
    }
}
