//
//  PersonDetailView.swift
//  ConsolidationVI
//
//  Created by Amier Davis on 5/24/26.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    @Environment(\.dismiss) var dismiss

    var person: Person

    @State private var name: String

    private let defaultCameraPosition: MapCameraPosition
    private let region: MKCoordinateRegion?

    @State private var cameraPosition: MapCameraPosition
    @State private var resetTask: Task<Void, Never>? = nil
    @State private var isAutoResetting = false

    @State private var sheetDetent: PresentationDetent = .fraction(0.3)
    @FocusState private var nameFieldFocused: Bool

    private let minimumDetentFraction: CGFloat = 0.3

    init(person: Person) {
        self.person = person
        self.name = person.name
        if let latitude = person.latitude, let longitude = person.longitude {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
            self.region = region
            let position = MapCameraPosition.region(region)
            self.defaultCameraPosition = position
            self._cameraPosition = State(initialValue: position)
        } else {
            self.region = nil
            self.defaultCameraPosition = .automatic
            self._cameraPosition = State(initialValue: .automatic)
        }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    person.image!
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                    TextField("Name", text: $name)
                        .multilineTextAlignment(.center)
                        .focused($nameFieldFocused)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.bottom, geometry.size.height * minimumDetentFraction + 20)
                .contentShape(Rectangle())
                .onTapGesture {
                    nameFieldFocused = false
                }
            }
            .sheet(isPresented: .constant(region != nil)) {
                Group {
                    if let region {
                        Map(position: $cameraPosition) {
                            Marker(person.name, coordinate: CLLocationCoordinate2D(latitude: person.latitude!, longitude: person.longitude!))
                        }
                        .onMapCameraChange(frequency: .onEnd) { _ in
                            // Ignore the camera-change event fired by our own reset animation.
                            if isAutoResetting {
                                isAutoResetting = false
                                return
                            }
                            scheduleReset()
                        }
                    }
                }
                    .presentationDetents([.fraction(minimumDetentFraction), .large], selection: $sheetDetent)
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(minimumDetentFraction)))
                    .interactiveDismissDisabled()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        person.name = name
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func scheduleReset() {
        resetTask?.cancel()
        resetTask = Task {
            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled else { return }
            await MainActor.run {
                isAutoResetting = true
                withAnimation(.easeInOut(duration: 1)) {
                    cameraPosition = defaultCameraPosition
                }
            }
        }
    }
}
