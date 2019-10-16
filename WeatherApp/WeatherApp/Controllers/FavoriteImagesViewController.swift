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
        tableView.register(FavoriteImagesTableViewCell.self, forCellReuseIdentifier: "favoriteImagesCell")
        tableView.delegate = self
        tableView.dataSource = self
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


extension FavoriteImagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension FavoriteImagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoriteImagesCell", for: indexPath) as! FavoriteImagesTableViewCell
        let favoriteImage = favorites[indexPath.row]
        let imageUrlStr = favoriteImage.url
        
        ImageHelper.manager.getImage(urlStr: imageUrlStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromURL):
                    cell.favoriteImageView.image = imageFromURL
                }
            }
        }
        return cell
    }
    
    
}
