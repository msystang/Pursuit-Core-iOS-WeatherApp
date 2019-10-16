//
//  Weather.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let daily: DailyWeatherResult
    
    static func decodeWeatherFromData(from jsonData: Data) throws -> Weather {
        let response = try JSONDecoder().decode(Weather.self, from: jsonData)
        return response
    }
}

struct DailyWeatherResult: Codable {
    let summary: String
    let icon: String
    let data: [Forecast]
}

struct Forecast: Codable {
    let time: Int
    let summary: String
    let icon: String
    let temperatureHigh: Double
    let temperatureLow: Double
    let sunriseTime: Int
    let sunsetTime: Int
    let windSpeed: Double
    let precipProbability: Double
    
    //TODO: Convert UNIX time to formatted time and date
    
    var convertedDate: NSDate {
        let date = NSDate(timeIntervalSince1970: TimeInterval(time))
        return date
        
//        let dateFormatter = DateFormatter()
    }
    
    var convertedTime: NSDate {
          let date = NSDate(timeIntervalSince1970: TimeInterval(time))
          return date
      }
    
}


