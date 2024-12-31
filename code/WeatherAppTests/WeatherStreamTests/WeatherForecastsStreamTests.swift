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

    func test_fetchWeatherForecasts_onSuccessShowNext5dayForecastsAndDropRests() {
        
        // Given
        let forecasts = WeatherFixtures.forcasts
        let response = ForecastResponse(list: forecasts)
        let maxCount = 5
        mockNetworkService.model = response

        expectation("Fetch weather forecasts successfully") { [weak self] expectation in
            
            guard let self else { return }
            // When
            weatherForecastsStream.forecasts
                .sink(receiveValue: { result in
                    if case .success(let items) = result {
                        XCTAssertEqual(items.count, maxCount, "Should show only \(maxCount) days forecasts.")
                        XCTAssertEqual(self.datesOnly(forecasts: items), [1,2,3,4,5] , "Should show only \(maxCount) days forecasts.")
                        expectation.fulfill()
                    } else {
                        XCTFail()
                    }
                })
                .store(in: &cancellables)
            weatherForecastsStream.fetchWeatherForecasts(for: "London")
        }
    }
    func testFetchWeatherForecastsFailure() {
        
        // Given
        expectation("Fetch weather forecasts fails") { [weak self] expectation in
            
            guard let self else { return }
            
            weatherForecastsStream.forecasts
                .sink(receiveValue: { result in
                    if case .failure(let error) = result {
                        // then
                        XCTAssertEqual((error as NSError).domain, "MockError", "Should return the correct error.")
                        expectation.fulfill()
                    } else {
                        XCTFail()
                    }
                })
                .store(in: &cancellables)
            //when
            weatherForecastsStream.fetchWeatherForecasts(for: "London")
        }
    }
}
private extension XCTestCase {
    
    func datesOnly(forecasts: [WeatherItem]) -> [Int] {
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        return forecasts.map({ calendar.component(.day, from: dateFormatter.date(from: $0.dt_txt) ?? Date()) })
    }
}
