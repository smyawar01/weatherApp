//
//  WeatherFixtures.swift
//  WeatherAppTests
//
//  Created by Yawar Muhammad  on 26/09/2024.
//

import Foundation
@testable import WeatherApp

struct WeatherFixtures {
    
    static var forcasts: [WeatherItem] {
        [
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-01 12:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-01 15:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-02 12:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-02 15:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-03 12:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-03 15:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-04 12:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-04 15:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-05 12:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-05 15:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-06 12:00:00"),
            WeatherItem(main: Main(temp: 15.0, temp_min: 10, temp_max: 20, humidity: 1), weather: [], dt_txt: "2023-09-06 15:00:00"),
        ]
    }
}
