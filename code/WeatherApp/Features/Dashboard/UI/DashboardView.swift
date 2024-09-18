//
//  DashboardView.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import SwiftUI

struct DashboardView<ViewModel: DashboardViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Enter city", text: $viewModel.city, onCommit: {
                    viewModel.fetchWeather()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                if let weather = viewModel.currentWeather {
                    
                    CurrentWeatherView(viewData: weather)
                        .padding()
                }
                if let error = viewModel.weatherError {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                }
                List(viewModel.forecasts, id: \.dt_txt) { item in
                    VStack(alignment: .leading) {
                        Text("Date: \(item.dt_txt)")
                        Text("Temperature: \(item.main.temp)°C")
                        Text("Description: \(item.weather.first?.description ?? "")")
                    }
                }
                if let error = viewModel.forecastError {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Weather Forecast")
        }
    }
}

//#Preview {
//    DashboardView(viewModel:)
//}
