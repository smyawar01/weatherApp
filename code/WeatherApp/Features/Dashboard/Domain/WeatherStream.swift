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
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    
                    self.forecastSubject.send(.failure(error))
                }
            }, receiveValue: { (response: WeatherResponse) in
                
                let maxCount = 5
                let firstFive = response.list.count <= maxCount ? response.list : Array(response.list.prefix(maxCount))
                self.forecastSubject.send(.success(firstFive))
            })
            .store(in: &cancellables)
    }
}
