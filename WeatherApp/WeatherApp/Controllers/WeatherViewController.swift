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
        label.text = "Label"
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var weatherCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
            self.weatherCollectionView.reloadData()
        }
    }

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        addSubviews()
        addConstraints()
        loadData()
    }

    // MARK: - Private Functions
    private func loadData() {
        var latitude = String()
        var longitude = String()
        
        ZipCodeHelper.getLatLong(fromZipCode: searchString ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    latitude = String(data.lat)
                    longitude = String(data.long)
                }
            }
        }
        
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
    
    // MARK: UI Object Constraints
    private func addSubviews() {
        self.view.addSubview(locationLabel)
        self.view.addSubview(searchBar)
        self.view.addSubview(weatherCollectionView)
    }
    
    private func addConstraints() {
        setLocationLabelConstraints()
        setSearchBarConstraints()
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
    
    private func setSearchBarConstraints() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 5),
            self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.searchBar.heightAnchor.constraint(equalToConstant: 50),
            self.searchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setCollectionViewConstraints() {
        self.weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.weatherCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 20),
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
        
        // Add image
        // Add High and Low temp labels
        
        return cell
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    // make flow horizontal
}

// MARK: - SearchBar Delegate Methods
extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText.lowercased()
    }
}
