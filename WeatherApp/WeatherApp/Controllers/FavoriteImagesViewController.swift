//
//  FavoriteImagesViewController.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteImagesViewController: UIViewController {
    
    var favorites = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadFavorites()
    }
    
    private func loadFavorites() {
        do {
            favorites = try ImagePersistenceHelper.manager.get()
        } catch {
            print(error)
        }
        
    }
    
}
