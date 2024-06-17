//
//  LocationView.swift
//  HistoryRoute
//
//  Created by abdullah on 16.06.2024.
//

import MapKit
import SwiftUI

struct LocationView: View {
    @EnvironmentObject private var vm: LocationsViewModel

    var body: some View {
        ZStack {
            mapLayerView
            .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                    .padding()

                Spacer()

                ZStack {
                    ForEach(vm.locations) { location in
                        if vm.mapLocation == location {
                            LocationPreviewView(location: location)
                                .padding()
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                    }
                }
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationsViewModel())
}

extension LocationView {
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationsList, label: {
                Text("\(vm.mapLocation.name) \(vm.mapLocation.cityName)")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
            }).foregroundStyle(.primary)

            if vm.showLocationList {
                LocationsListView()
            }
            else {}
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }

    private var mapLayerView: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in

                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                }
            })
    }
}
