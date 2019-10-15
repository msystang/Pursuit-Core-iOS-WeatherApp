//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var locationIamgeView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var precipChanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [highTempLabel, lowTempLabel, sunriseLabel, sunsetLabel, windSpeedLabel, precipChanceLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    var selectedForecast: Forecast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
