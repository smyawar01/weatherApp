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
    var result: AnyPublisher<Decodable, Error>?
    
    func perform<Model: Decodable>(request: URLRequest) -> AnyPublisher<Model, Error> {
        // Cast the result to the expected Model type or return a Fail publisher
        if let result = result as? AnyPublisher<Model, Error> {
            return result
        }
        return Fail(error: NSError(domain: "MockError", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }
}

