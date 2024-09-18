//
//  DashboardViewModel.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import Foundation
import Combine

protocol DashboardViewModelProtocol: ObservableObject {
    
    var forecasts: [WeatherItem] { get }
    var error: String? { get }
    var city: String { get set }
    
    func fetchWeather()
}
class DashboardViewModel: DashboardViewModelProtocol {
    
    //MARK: Private
    private var weatherStream: WeatherForecastsStream
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Public
    @Published var forecasts: [WeatherItem] = []
    @Published var error: String?
    @Published var city: String = ""
    
    public init(weatherStream: WeatherForecastsStream) {
        
        self.weatherStream = weatherStream
        self.bindForecasts()
    }
    func fetchWeather() {
        
        weatherStream.fetchWeatherForecasts(for: city)
    }
}
private extension DashboardViewModel {
    
    func bindForecasts() {
        
        weatherStream.forecasts.sink { result in
            
            switch result {
            case .success(let items):
                self.forecasts = items
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
        .store(in: &cancellables)
    }
}
