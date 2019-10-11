//
//  Weather.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Weather: Codable {
    static func decodeWeatherFromData(from jsonData: Data) throws -> [Weather] {
        let response = try JSONDecoder().decode([Weather].self, from: jsonData)
        return response
    }
}
