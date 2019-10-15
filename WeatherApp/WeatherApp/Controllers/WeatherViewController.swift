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
        return label
    }()
    
    lazy var weatherCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .default
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: - Private Properties
    private var weather = [Forecast]() {
        didSet {
            weatherCollectionView.reloadData()
        }
    }
    
    private var searchWord: String? {
        didSet {
            weatherCollectionView.reloadData()
        }
    }

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "weatherCell")
    }

    // MARK: - Private Functions
    private func loadData() {
        var latitude = String()
        var longitude = String()
        
        ZipCodeHelper.getLatLong(fromZipCode: searchWord ?? "") { (result) in
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
        self.searchWord = searchText.lowercased()
    }
}
