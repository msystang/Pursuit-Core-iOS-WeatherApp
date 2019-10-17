//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Lazy Objects
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var highTempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [highTempLabel, lowTempLabel])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Functions
    override func prepareForReuse() {
         super.prepareForReuse()
    }

    // MARK: - UI Constraint Methods
    private func addSubviews() {
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(weatherImageView)
        self.contentView.addSubview(labelStackView)
    }
    
    private func addConstraints() {
        setDateLabelConstraints()
        setWeatherImageViewConstraints()
        setLabelStackViewConstraints()

    }
    
    private func setDateLabelConstraints() {
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setWeatherImageViewConstraints() {
        self.weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.weatherImageView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 5),
            self.weatherImageView.heightAnchor.constraint(equalToConstant: 100),
            self.weatherImageView.widthAnchor.constraint(equalToConstant: 100),
            self.weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setLabelStackViewConstraints() {
        self.labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.labelStackView.topAnchor.constraint(equalTo: self.weatherImageView.bottomAnchor, constant: 5),
            self.labelStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.labelStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 5),
            self.labelStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
    }
    
    
}
