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

    // MARK: - Test Weather Model
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
    
    // MARK: - Test Image Model
    func testGetImageDataFromJSON() {
        // Arrange
        guard let jsonPath = Bundle.main.path(forResource: "images", ofType: "json") else {
            fatalError("JSON file not found")
        }
        
        var jsonData = Data()
        do {
            jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
        } catch {
            print(error)
        }
        
        // Act
        var images = [Image]()
        do {
            let imageInfo = try ImageWrapper.decodeImagesFromData(from: jsonData)
            images = imageInfo
        }
        catch {
            print(error)
        }
            
        // Assert
        XCTAssertTrue(images.count == 20, "Was expecting 20 elements, but found \(images.count)")
    }
    
    // MARK: - Test Persistence
    private var testImages = [Image]()
    private let imageOne = Image(url: "testUrlOne")
    private let imageTwo = Image(url: "testUrlTwo")
        
    private func saveImagePersistence() {
        do {
            try ImagePersistenceHelper.manager.save(newImage: imageOne)
            try ImagePersistenceHelper.manager.save(newImage: imageTwo)
        } catch {
            print(error)
        }
    }

    func testLoadImagePersistence() {
//        saveImagePersistence()
        
        do {
            testImages = try ImagePersistenceHelper.manager.get()
            print(testImages.count)
        } catch {
            print(error)
            XCTFail()
        }
        
        XCTAssertTrue(testImages[0].url == imageOne.url, "Expected URL: \(imageOne.url), got \(testImages[0].url)")
        XCTAssertTrue(testImages[1].url == imageTwo.url, "Expected URL: \(imageTwo.url), got \(testImages[1].url)")
         
        }

    func testDeletePersistedObject() {
        do {
            try ImagePersistenceHelper.manager.deleteImage(with: imageOne.url)
            try ImagePersistenceHelper.manager.deleteImage(with: imageTwo.url)
        } catch {
            print(error)
        }
        
        XCTAssertTrue(testImages.count == 0, "Expected: 0, Got: \(testImages.count)")
    }

}
