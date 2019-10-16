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
    
    var timeAsTimeInterval: Date {
        let timeInterval = Date(timeIntervalSince1970: TimeInterval(time))
        return timeInterval
    }
    
    var formattedDate: String {
        let oldDateFormat = DateFormatter()
        oldDateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "EEEE, MMM d, yyyy"
        return newDateFormat.string(from: timeAsTimeInterval)
    }
    
    var formattedTime: String {
        let oldDateFormat = DateFormatter()
        oldDateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "h:mm a"
        return newDateFormat.string(from: timeAsTimeInterval)
    }
    
}


