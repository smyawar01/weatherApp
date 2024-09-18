//
//  AppComponent.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import Foundation

struct AppComponent {
    
    let networkService = NetworkServiceImpl(session: URLSession.shared)
    var dashboardComponent: DashboardComponent {
        
        DashboardComponent(networkService: networkService)
    }
}
