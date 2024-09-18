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
    var weatherError: String? { get }
    var forecastError: String? { get }
    var city: String { get set }
    var currentWeather: CurrentWeather? { get }
    
    func fetchWeather()
}
class DashboardViewModel: DashboardViewModelProtocol {
    
    //MARK: Private
    private var currentStream: CurrentWeatherStream
    private var forecastStream: WeatherForecastsStream
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Public
    @Published var forecasts: [WeatherItem] = []
    @Published var weatherError: String?
    @Published var forecastError: String?
    @Published var city: String = ""
    @Published var currentWeather: CurrentWeather?
    
    public init(currentStream: CurrentWeatherStream, forecastStream: WeatherForecastsStream) {
        
        self.currentStream = currentStream
        self.forecastStream = forecastStream
        self.bindForecasts()
        self.bindCurrentWeather()
    }
    func fetchWeather() {
        
        currentStream.fetchCurrentWeather(for: city)
        forecastStream.fetchWeatherForecasts(for: city)
    }
}
private extension DashboardViewModel {
    
    func bindForecasts() {
        
        forecastStream.forecasts.sink { result in
            
            switch result {
            case .success(let items):
                self.forecasts = items
            case .failure(let error):
                self.forecastError = error.localizedDescription
            }
        }
        .store(in: &cancellables)
    }
    func bindCurrentWeather() {
        
        currentStream.weather.sink { result in
            
            switch result {
            case .success(let weather):
                self.currentWeather = weather
            case .failure(let error):
                self.weatherError = error.localizedDescription
            }
        }
        .store(in: &cancellables)
    }
}
