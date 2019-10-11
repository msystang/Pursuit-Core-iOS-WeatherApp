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
        guard let jsonPath = Bundle.main.path(forResource: "weather", ofType: "json"),
                let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
                    fatalError("Test JSON data not found")
            }
            
            // Act
            var weather = [Weather]()
            
            do {
                weather = try Weather.decodeWeatherFromData(from: jsonData)
            }
            catch {
                print(error)
            }
            
            // Assert
            XCTAssertTrue(weather.count == 20, "Was expecting 20 elements, but found \(weather.count)")
    }
    
}
