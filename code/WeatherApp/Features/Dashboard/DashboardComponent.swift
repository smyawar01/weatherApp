//
//  DashboardComponent.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import Foundation
import SwiftUI

struct DashboardComponent: DashboardViewBuilder {
    
    let networkService: NetworkService
    
    var dashboardViewModel: DashboardViewModel {
        
        DashboardViewModel(weatherStream: WeatherForecastsStreamImpl(networkService: networkService))
    }
    var dashboardView: AnyView {
        
        AnyView(
            DashboardView(viewModel: dashboardViewModel)
        )
    }
    
}
protocol DashboardViewBuilder {
    
    var dashboardView: AnyView { get }
}
