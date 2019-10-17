//
//  UserDefaultsWrapper.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    
    // MARK: - Static Properties
    static let manager = UserDefaultsWrapper()
    
    // MARK: - Internal Getter methods
    func getSearchString() -> String? {
        return UserDefaults.standard.value(forKey: searchStringKey) as? String
    }
    
    // MARK: - Internal Setter methods
    func store(searchString: String) {
        UserDefaults.standard.set(searchString, forKey: searchStringKey)
    }
    
    // MARK: - Private Properties
    private let searchStringKey = "searchStringKey"
    
    // MARK: - Private inits
    private init() {}
}
