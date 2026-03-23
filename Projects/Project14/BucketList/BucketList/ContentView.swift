//
//  ContentView.swift
//  BucketList
//
//  Created by Amier Davis on 3/1/26.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.4173, longitude: -82.9071),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var isHybrid = false
    
    var body: some View {
        if viewModel.isUnlocked {
            NavigationStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .contentShape(.circle)
                                    .onTapGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(isHybrid ? .hybrid : .standard)
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                            }
                        }
                        
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(location: place) { newLocation in
                                viewModel.update(location: newLocation)
                            }
                        }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Switch Map Mode") { isHybrid.toggle() }
                    }
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Authentication Error", isPresented: $viewModel.showingAuthError) {
                    Button("Ok") { }
                } message: {
                    Text(viewModel.authErrorMessage)
                }
        }
    }
}

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Location {
    #if DEBUG
    static let example = Location(
        id: UUID(),
        name: "Buckingham Palace",
        description: "Lit by over 40,000 lightbulbs.",
        latitude: 51.501, longitude: -0.141
    )
    #endif
}

extension Location {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

#Preview {
    ContentView()
}
