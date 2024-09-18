//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 18/09/2024.
//


public struct CurrentWeather: Decodable {
    
    let temperature: Double
    let humidity: Int
    let windSpeed: String
    let description: String
}
