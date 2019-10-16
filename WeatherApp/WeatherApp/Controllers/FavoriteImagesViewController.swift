//
//  FavoriteImagesViewController.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteImagesViewController: UIViewController {
    
    lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var favorites = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadFavorites()
        addSubviews()
        addConstraints()
    }
    
    private func loadFavorites() {
        do {
            favorites = try ImagePersistenceHelper.manager.get()
        } catch {
            print(error)
        }
        
    }
    
    private func addSubviews() {
        view.addSubview(favoritesTableView)
    }
    
    private func addConstraints() {
        setTableViewConstraints()
    }
    
    private func setTableViewConstraints() {
        favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
