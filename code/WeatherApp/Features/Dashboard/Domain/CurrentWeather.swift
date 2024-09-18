//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 18/09/2024.
//


public struct CurrentWeather: Decodable {
    
    let temperature: String
    let humidity: String
    let windSpeed: String
    let description: String
}
