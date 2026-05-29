//
//  ContentView.swift
//  ConsolidationVI
//
//  Created by Amier Davis on 5/24/26.
//

import SwiftUI
import PhotosUI
import SwiftData
import SwiftyCrop

struct ContentView: View {
    @Query(sort: \Person.name, order: .forward) private var people: [Person]
    @Environment(\.modelContext) var modelContext

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedPhoto: Image? = nil
    @State private var selectedUIImage: UIImage? = nil
    @State private var rawUIImage: UIImage? = nil

    @State private var showingNameAlert = false
    @State private var showingCropView = false

    @State private var newName = ""

    @State private var selectedPerson: Person? = nil

    let locationFetcher = LocationFetcher()

    var body: some View {
        NavigationStack {
            Group {
                if people.isEmpty {
                    VStack {
                        PhotosPicker(selection: $selectedItem) {
                            if let photo = selectedPhoto {
                                photo
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(.circle)
                            } else {
                                photoPlaceholder
                            }
                        }
                        .buttonStyle(.plain)

                        Text("Add your first person!")
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(people) { person in
                        Button {
                            selectedPerson = person
                        } label: {
                            HStack {
                                if let img = person.image {
                                    img
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(.circle)
                                }
                                Text(person.name)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            PhotosPicker(selection: $selectedItem) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }
            .navigationTitle("FaceName")
        }
        .onChange(of: selectedItem) { _, newItem in
            guard let newItem else { return }
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    rawUIImage = uiImage
                    locationFetcher.start()
                    showingCropView = true
                }
            }
        }
        // After SwiftyCropView dismisses, show the name alert if a crop was confirmed.
        .onChange(of: showingCropView) { _, isShowing in
            if !isShowing && selectedUIImage != nil {
                showingNameAlert = true
            }
        }
        .fullScreenCover(isPresented: $showingCropView) {
            if let raw = rawUIImage {
                SwiftyCropView(imageToCrop: raw, maskShape: .circle) { croppedImage in
                    guard let croppedImage else {
                        reset()
                        return
                    }
                    selectedUIImage = croppedImage
                    selectedPhoto = Image(uiImage: croppedImage)
                }
            }
        }
        .alert("Enter Name", isPresented: $showingNameAlert) {
            TextField("Name", text: $newName)
            Button(role: .confirm) {
                withAnimation {
                    let location = locationFetcher.lastKnownLocation
                    modelContext.insert(Person(name: newName, uiImage: selectedUIImage!, location: location))
                    reset()
                }
            } label: {
                Text("Done")
            }
        }
        .sheet(item: $selectedPerson) { person in
            PersonDetailView(person: person)
        }
    }

    var photoPlaceholder: some View {
        ZStack {
            Circle()
                .frame(width: 120, height: 120)
                .foregroundStyle(.gray.opacity(0.2))
            VStack(spacing: 4) {
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 44))
                Text("Add Photo")
                    .font(.caption)
            }
            .foregroundStyle(.gray)
        }
    }

    func reset() {
        selectedItem = nil
        selectedPhoto = nil
        selectedUIImage = nil
        rawUIImage = nil
        newName = ""
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Person.self, inMemory: true)
}
