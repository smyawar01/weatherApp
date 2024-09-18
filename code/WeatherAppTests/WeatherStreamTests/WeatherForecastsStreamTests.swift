//
//  WeatherForecastsStreamTests.swift
//  WeatherForecastsStreamTests
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import XCTest
import Combine
@testable import WeatherApp

class WeatherForecastsStreamTests: XCTestCase {
    
    var weatherForecastsStream: WeatherForecastsStreamImpl!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        weatherForecastsStream = WeatherForecastsStreamImpl(networkService: mockNetworkService)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        weatherForecastsStream = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchWeatherForecastsSuccess() {
        // Given
        let weatherItems = [
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-01 12:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-01 15:00:00"),
        ]
        let response = ForecastResponse(list: weatherItems)
        mockNetworkService.result = Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher() as AnyPublisher<Decodable, Error>

        let expectation = XCTestExpectation(description: "Fetch weather forecasts successfully")

        // When
        weatherForecastsStream.forecasts
            .sink(receiveValue: { result in
                if case .success(let items) = result {
                    XCTAssertEqual(items.count, 2, "Should return only 2 items.")
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)

        weatherForecastsStream.fetchWeatherForecasts(for: "London")
        
        //Test is failed due to unable to typecast in network service which is being investigated.
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchWeatherForecastsFailure() {
        
        // Given
        let expectation = XCTestExpectation(description: "Fetch weather forecasts fails")

        // When
        weatherForecastsStream.forecasts
            .sink(receiveValue: { result in
                if case .failure(let error) = result {
                    XCTAssertEqual((error as NSError).domain, "MockError", "Should return the correct error.")
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)

        weatherForecastsStream.fetchWeatherForecasts(for: "London")

        wait(for: [expectation], timeout: 1.0)
    }
}
