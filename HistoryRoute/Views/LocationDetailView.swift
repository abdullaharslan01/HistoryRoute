import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location

    var body: some View {
        ScrollView {
            VStack {
                imageSectionView
            }

            VStack(alignment: .leading, spacing: 16) {
                titleSectionView
                Divider()
                descriptionSectionView
                Divider()
                mapLayerView
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .ignoresSafeArea(edges: .top)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}

extension LocationDetailView {
    private var imageSectionView: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
        .overlay(alignment: .topLeading) {
            Button(action: {
                vm.sheetLocation = nil
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .padding(25)
                    .foregroundStyle(.primary)
                    .background(.thickMaterial)
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(20)
            })
        }
    }

    private var titleSectionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSectionView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                    
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
    }
    
    private var mapLayerView: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: vm.span)), annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnotationView()
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fill)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}
