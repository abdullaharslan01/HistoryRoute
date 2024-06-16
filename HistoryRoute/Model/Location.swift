//
//  Location.swift
//  HistoryRoute
//
//  Created by abdullah on 16.06.2024.
//

import MapKit

struct Location: Identifiable, Equatable{
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    var id: String {
        name + cityName
    }
    
    
}
