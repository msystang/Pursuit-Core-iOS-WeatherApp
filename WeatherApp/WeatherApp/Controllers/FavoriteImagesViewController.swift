//
//  FavoriteImagesViewController.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteImagesViewController: UIViewController {
    
    // MARK: - UI Lazy Objects
    lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteImagesTableViewCell.self, forCellReuseIdentifier: "favoriteImagesCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Internal Properties
    var favorites = [Image]() {
        didSet {
            favoritesTableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewController()
        addSubviews()
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadFavorites()
    }
    
    // MARK: - Private Methods
    private func setUpViewController() {
        view.backgroundColor = .white
    }
    
    private func loadFavorites() {
        do {
            favorites = try ImagePersistenceHelper.manager.get()
        } catch {
            print(error)
            showLoadErrorAlert(error: error)
        }
    }
    
    private func showLoadErrorAlert(error: Error) {
        let alertVC = UIAlertController(title: "Error", message: "Could not load favorites: \(error).", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - UI Constraint Methods
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

// MARK: - TableView Delegate & DataSource Methods
extension FavoriteImagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
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
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 0.9725163579, blue: 0.7653290629, alpha: 1)
        
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
