//
//  AppConfig.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import Foundation

struct AppConfig {
    static let baseUrl: String = {
        
        print(Bundle.main.infoDictionary ?? "Info.plist not found")
        guard let url = Bundle.main.infoDictionary?["API_URL"] as? String else {
            fatalError("API_URL not found")
        }
        return url
    }()
    
    static let weatherApiKey: String = {
        guard let key = Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String else {
            fatalError("API_KEY not found")
        }
        return key
    }()
}
