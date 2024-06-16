//
//  HistoryRouteApp.swift
//  HistoryRoute
//
//  Created by abdullah on 16.06.2024.
//

import SwiftUI

@main
struct HistoryRouteApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
