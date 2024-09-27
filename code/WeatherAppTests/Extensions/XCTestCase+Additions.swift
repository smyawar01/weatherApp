//
//  XCTestCase+Extenstions.swift
//  WeatherAppTests
//
//  Created by Yawar Muhammad  on 27/09/2024.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func expectation(_ description: String,
                     timeout: TimeInterval = 1.0,
                     completion: @escaping (XCTestExpectation) -> Void) {
        
        let expectation = XCTestExpectation(description: description)
        completion(expectation)
        wait(for: [expectation], timeout: timeout)
    }
}
