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
        label.text = "Welcome"
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.backgroundColor = .white
        textField.placeholder = "Enter ZipCode or City"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    
    lazy var weatherCollectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 0.9725163579, blue: 0.7653290629, alpha: 1)
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
            self.weatherCollectionView.reloadData()
            
            if let searchString = searchString {
                UserDefaultsWrapper.manager.store(searchString: searchString)
            }
        }
    }

    private var latitude = String()
    private var longitude = String()
    private var locationName = String()
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpViewController()
        addSubviews()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setInitialValuesFromUserDefaults()
    }

    // MARK: - Private Functions
    private func setUpViewController() {
        self.navigationItem.title = "Search"
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9725163579, blue: 0.7653290629, alpha: 1)
    }
    
    private func setInitialValuesFromUserDefaults() {
        if let savedSearchString = UserDefaultsWrapper.manager.getSearchString() {
            searchString = savedSearchString
        }
        
    }
    
    private func loadLatLongFromZip() {
        ZipCodeHelper.getLatLong(fromZipCodeOrCity: searchString ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.showLocationErrorAlert()
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
                        self.showDataErrorAlert(error: error)
                        print(error)
                    case .success(let data):
                        self.weather = data
                }
            }
        }
    }
    
    private func showLocationErrorAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Could not find location. Check your input.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
       }
    
    private func showDataErrorAlert(error: Error) {
        let alertVC = UIAlertController(title: "Error", message: "Could not load weather data: \(error). Check your internet connection.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func updateLocationLabel() {
        self.locationLabel.text = "Weekly Forecast for \(locationName)"
    }
    
    // MARK: - UI Object Constraints
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
            self.textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: 30),
            self.textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50)

        ])
    }
    
    private func setCollectionViewConstraints() {
        self.weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.weatherCollectionView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            self.weatherCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.weatherCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.weatherCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
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
        
        let date = dailyWeather.formattedDate
        cell.dateLabel.text = date
        
        if let image = UIImage(named: dailyWeather.icon) {
            cell.weatherImageView.image = image
        } else {
            cell.weatherImageView.image = UIImage(named: "na")
        }
        
        cell.highTempLabel.text = "High: \(dailyWeather.temperatureHigh) °F"
        cell.lowTempLabel.text = "Low: \(dailyWeather.temperatureLow) °F"
        
        cell.backgroundColor = .white
    
        
        return cell
    }
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width * 0.7 , height: view.bounds.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = CityDetailViewController()
        detailVC.selectedForecast = weather[indexPath.row]
        detailVC.locationName = locationName
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

// MARK: - TextField Delegate Methods
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchString = textField.text
        textField.resignFirstResponder()
        return true
    }
}
