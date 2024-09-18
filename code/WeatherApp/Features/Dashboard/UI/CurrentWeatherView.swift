//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 18/09/2024.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    let viewData: CurrentWeather
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Temprature: \(viewData.temperature)")
            Text("Humidity: \(viewData.humidity)")
            Text("Wind Speed: \(viewData.windSpeed)")
            Text("Description: \(viewData.description)")
        }
    }
}

#Preview {
    CurrentWeatherView(viewData: CurrentWeather(temperature: "39 C",
                                                humidity: "20",
                                                windSpeed: "34 mph",
                                                description: "Today is windy"))
}
