//
//  MockNetworkService.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 18/09/2024.
//

import Combine
import Foundation
@testable import WeatherApp


class MockNetworkService: NetworkService {
    
    // A variable to hold the result that will be returned by the perform method
    var model: Decodable?
    
    func perform<Model: Decodable>(request: URLRequest) -> AnyPublisher<Model, Error> {
        
        if let model = model as? Model {
            
            return Just(model)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return Fail(error: NSError(domain: "MockError", code: 500)).eraseToAnyPublisher()
    }
}

