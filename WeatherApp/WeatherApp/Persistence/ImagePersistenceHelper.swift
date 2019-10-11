//
//  ImagePersistenceHelper.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class ImagePersistenceHelper {
    static let manager = ImagePersistenceHelper()
    
    func save(newImage: Image) throws {
        try persistenceHelper.save(newElement: newImage)
    }
    
    func get() throws -> [Image] {
        return try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceManager<Image>(fileName: "favoriteImages.plist")
    
    private init() {}
}
