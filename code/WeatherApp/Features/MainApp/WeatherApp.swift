//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Yawar Muhammad  on 17/09/2024.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    let rootComponent = AppComponent().dashboardComponent
    var body: some Scene {
        WindowGroup {
            rootComponent.dashboardView
        }
    }
}
