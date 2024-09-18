//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import Foundation

public struct WeatherItem: Codable {
    let main: Main
    let weather: [Weather]
    let dt_txt: String
}

public struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

public struct Weather: Codable {
    let description: String
}

