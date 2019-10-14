//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class WeatherAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = WeatherAPIClient()
    
    // MARK: - Instance Methods
    
    static func getSearchResultsURLStr(from latitude: String, longitude: String) -> String {
        return "https://api.darksky.net/forecast/\(Secrets.darkSkyAPIKey)/\(latitude),\(longitude)?exclude=[minutely,hourly,alerts,flags]"
    }
    
    func getWeather(urlStr: String, completionHandler: @escaping (Result<[Weather], AppError>) -> ())  {
        
        guard let url = URL(string: urlStr) else {
            print(AppError.badURL)
            return
        }
        
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let weatherInfo = try Weather.decodeWeatherFromData(from: data)
                    completionHandler(.success(weatherInfo))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }
        }
    }
    
    // MARK: - Private Properties and Initializers
    
    private init() {}
}
