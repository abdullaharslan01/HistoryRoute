//
//  LocationsViewModel.swift
//  HistoryRoute
//
//  Created by abdullah on 16.06.2024.
//

import SwiftUI
import MapKit


final class LocationsViewModel: ObservableObject{
    
    @Published var locations: [Location] = []
  
    @Published var mapLocation: Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    @Published var mapRegion:MKCoordinateRegion = MKCoordinateRegion()
    
    let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationList: Bool = false
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: span)
        }
       
    }
    
     func toggleLocationsList(){
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location:Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    
}
