//
//  ImagePersistenceHelper.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class ImagePersistenceHelper {
    
    // MARK: - Static Properties
    static let manager = ImagePersistenceHelper()
    
    // MARK: - Instance Methods
    func save(newImage: Image) throws {
        try persistenceHelper.save(newElement: newImage)
    }
    
    func get() throws -> [Image] {
        return try persistenceHelper.getObjects().reversed()
    }

    func deleteImage(with urlStr: String) throws {
        try persistenceHelper.delete(elementWith: urlStr)
    }
    
    // MARK: - Private Properties and Initializers
    private let persistenceHelper = PersistenceManager<Image>(fileName: "favoriteImages.plist")
    
    private init() {}
}
