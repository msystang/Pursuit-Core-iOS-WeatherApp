//
//  ImageAPIClient.swift
//  WeatherApp
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class ImageAPIClient {
    
    // MARK: - Static Properties
    static let manager = ImageAPIClient()
    
    // MARK: - Instance Methods
    static func getSearchResultsURLStr(from searchString: String) -> String {
        let formattedString = searchString.replacingOccurrences(of: " ", with: "+")
        
        return "https://pixabay.com/api/?key=\(Secrets.pixabayAPIKey)&q=\(formattedString)"
    }

    func getImage(urlStr: String, completionHandler: @escaping (Result<[Image], AppError>) -> ())  {
        
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
                    let imageInfo = try ImageWrapper.decodeImagesFromData(from: data)
                    completionHandler(.success(imageInfo))
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
