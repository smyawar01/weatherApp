//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import Foundation
import Combine

public protocol NetworkService {
    
    func perform<Model: Decodable>(request: URLRequest) -> AnyPublisher<Model, Error>
}

public struct NetworkServiceImpl: NetworkService {
    
    //MARK: Private
    private let session: URLSession
    
    //MARK: Public
    public init(session: URLSession) {
        self.session = session
    }
    public func perform<Model: Decodable>(request: URLRequest) -> AnyPublisher<Model, Error> {
        
        return URLSession.shared.dataTaskPublisher(for: request.url!)
            .map(\.data)
            .decode(type: Model.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
