//
//  Image.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Image: Codable {
    static func decodeImageFromData(from jsonData: Data) throws -> [Image] {
         let response = try JSONDecoder().decode([Image].self, from: jsonData)
         return response
     }
}
