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
            VStack {
                TextField("Enter city", text: $viewModel.city, onCommit: {
                    viewModel.fetchWeather()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                if let error = viewModel.error {
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
            }
            .navigationTitle("Weather Forecast")
        }
    }
}

//#Preview {
//    DashboardView(viewModel:)
//}
