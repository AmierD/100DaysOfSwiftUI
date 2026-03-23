//
//  ContentViewViewModel.swift
//  BucketList
//
//  Created by Amier Davis on 3/17/26.
//

import LocalAuthentication
import CoreLocation
import Foundation
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        var isUnlocked = false
        
        var showingAuthError = false
        var authErrorMessage = ""
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(
                id: UUID(),
                name: "New Location",
                description: "",
                latitude: point.latitude,
                longitude: point.longitude)
            
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                        return
                    } else {
                        // error
                        self.authErrorMessage = authenticationError?.localizedDescription ?? "Error"
                        self.showingAuthError = true
                    }
                }
            } else {
                // no biometrics
                self.authErrorMessage = error?.localizedDescription ?? "Error"
                self.showingAuthError = true
            }
        }
    }
}
