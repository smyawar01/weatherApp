//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import Foundation


public struct WeatherResponse: Decodable {
    
    struct Wind: Decodable {
        
        let speed: Double
    }
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

public struct ForecastResponse: Decodable {
    
    let list: [WeatherItem]
}
