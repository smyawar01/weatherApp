//
//  GetWeatherUseCase.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import Foundation

import Foundation
import Combine

public protocol WeatherForecastsStream {
    
    var forecasts: AnyPublisher<Result<[WeatherItem], Error>, Never> { get }
    func fetchWeatherForecasts(for city: String)
}

public protocol CurrentWeatherStream {
    
    var weather: AnyPublisher<Result<CurrentWeather, Error>, Never> { get }
    func fetchCurrentWeather(for city: String)
}

public final class WeatherForecastsStreamImpl: WeatherForecastsStream {
    
    //MARK: Private
    private let networkService: NetworkService
    private var forecastSubject = PassthroughSubject<Result<[WeatherItem], Error>, Never>()
    private var cancellables = Set<AnyCancellable>()

    //MARK: Public
    public var forecasts: AnyPublisher<Result<[WeatherItem], Error>, Never> {
        
        forecastSubject.eraseToAnyPublisher()
    }
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    public func fetchWeatherForecasts(for city: String) {
        
        let url = URL(string: "\(AppConfig.baseUrl)/forecast?q=\(city)&APPID=\(AppConfig.weatherApiKey)")!
        
        networkService.perform(request: URLRequest(url: url))
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    
                    self?.forecastSubject.send(.failure(error))
                }
            }, receiveValue: { [weak self] (response: ForecastResponse) in
                
                guard let self else { return }
                forecastSubject.send(.success(nextFiveDaysForecasts(from: response)))
            })
            .store(in: &cancellables)
    }
}
private extension WeatherForecastsStreamImpl {
    
    func nextFiveDaysForecasts(from response: ForecastResponse) -> [WeatherItem] {
        
        var groupedResult = [String: WeatherItem]()
        let calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss"
        
        for weather in response.list {
            
            // Extract the date component
            guard let date = dateFormatter.date(from: weather.dt_txt) else { continue }
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            let dateString = "\(dateComponents.year!)-\(dateComponents.month!)-\(dateComponents.day!)"
            
            // If a weather item for that date does not exist, add it
            if groupedResult[dateString] == nil {
                
                groupedResult[dateString] = weather
            }
            if groupedResult.count == 5 { break }
        }
        return groupedResult.sorted(by: { $0.key < $1.key }).map({ $0.value })
    }
}

public class CurrentWeatherStreamImpl: CurrentWeatherStream {
    
    //MARK: Private
    private let networkService: NetworkService
    private let currentWeatherSubject = PassthroughSubject<Result<CurrentWeather, Error>, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Public
    public var weather: AnyPublisher<Result<CurrentWeather, Error>, Never> {
        
        currentWeatherSubject.eraseToAnyPublisher()
    }
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    public func fetchCurrentWeather(for city: String) {
        
        let url = URL(string: "\(AppConfig.baseUrl)/weather?q=\(city)&APPID=\(AppConfig.weatherApiKey)")!
        
        networkService.perform(request: URLRequest(url: url))
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    
                    self?.currentWeatherSubject.send(.failure(error))
                }
            }, receiveValue: { [weak self] (response: WeatherResponse) in
                
                let weather = CurrentWeather(temperature: "\(response.main.temp)",
                                              humidity: "\(response.main.humidity)",
                                              windSpeed: "\(response.wind.speed)",
                                             description: "\(response.weather.first?.description ?? "Not Available")")
                self?.currentWeatherSubject.send(.success(weather))
            })
            .store(in: &cancellables)
    }
}
