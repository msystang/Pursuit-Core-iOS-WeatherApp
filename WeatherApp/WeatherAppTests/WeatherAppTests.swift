//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Sunni Tang on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import XCTest

class WeatherAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetWeatherDataFromJSON() {
        // Arrange
        guard let jsonPath = Bundle.main.path(forResource: "weather", ofType: "json") else {
            fatalError("JSON file not found")
        }
        
        var jsonData = Data()
        
        do {
            jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
        } catch {
            print(error)
        }
        
        // Act
        var forecast = [Forecast]()
            
        do {
            let weatherInfo = try Weather.decodeWeatherFromData(from: jsonData)
                forecast = weatherInfo.daily.data
        }
        catch {
            print(error)
        }
            
        // Assert
        XCTAssertTrue(forecast.count == 8, "Was expecting 8 elements, but found \(forecast.count)")
    }
    
    
    //TODO: Test image model!!! 
}
