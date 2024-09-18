//
//  CurrentWeatherStream.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 18/09/2024.
//

import Foundation
import Combine

public protocol CurrentWeatherStream {
    
    var weather: AnyPublisher<Result<CurrentWeather, Error>, Never> { get }
    func fetchCurrentWeather(for city: String)
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
                
                guard let self else { return }
                self.currentWeatherSubject.send(.success(self.mapper(from: response)))
            })
            .store(in: &cancellables)
    }
}
private extension CurrentWeatherStreamImpl {
    
    func mapper(from response: WeatherResponse) -> CurrentWeather {
        
        return CurrentWeather(temperature: "\(response.main.temp)",
                              humidity: "\(response.main.humidity)",
                              windSpeed: "\(response.wind.speed)",
                              description: "\(response.weather.first?.description ?? "Not Available")")
    }
}
