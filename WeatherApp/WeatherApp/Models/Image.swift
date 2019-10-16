//
//  Image.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct ImageWrapper: Codable {
    let hits: [Image]
    
    static func decodeImagesFromData(from jsonData: Data) throws -> [Image] {
        let response = try JSONDecoder().decode(ImageWrapper.self, from: jsonData)
        return response.hits
    }
}

struct Image: Codable {
    let url: String
//    var imageData: Data {
//
//    }
    
    private enum CodingKeys: String, CodingKey {
        case url = "largeImageURL"
    }
    
    static func getRandomImage(images: [Image]) -> Image {
        guard let randomImage = images.randomElement() else {
            // ToDo: add default image
            fatalError("No random image")
        }
        return randomImage
    }
    
}
