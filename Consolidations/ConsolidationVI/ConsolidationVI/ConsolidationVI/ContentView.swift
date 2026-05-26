//
//  ContentView.swift
//  ConsolidationVI
//
//  Created by Amier Davis on 5/24/26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Person.name, order: .forward) private var people: [Person]
    @Environment(\.modelContext) var modelContext
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedPhoto: Image? = nil
    @State private var selectedUIImage: UIImage? = nil
    
    @State private var showingNameAlert = false
    
    @State private var newName = ""
    
    @State private var selectedPerson: Person? = nil
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem) {
                if let photo = selectedPhoto {
                    photo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                } else {
                    photoPlaceholder
                }
            }
            .buttonStyle(.plain)
            List(people) { person in
                Button {
                    selectedPerson = person
                } label: {
                    HStack {
                        if let img = person.image {
                            img
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Text(person.name)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .onChange(of: selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                    selectedPhoto = Image(uiImage: uiImage)
                    selectedUIImage = uiImage
                    showingNameAlert = true
                }
            }
        }
        .alert("Enter Name", isPresented: $showingNameAlert) {
            TextField("Name", text: $newName)
            Button(role: .confirm) {
                withAnimation {
                    modelContext.insert(Person(name: newName, uiImage: selectedUIImage!))
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
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 175, height: 175)
                .foregroundStyle(.gray.opacity(0.5))
            VStack {
                Image(systemName: "photo.badge.plus")
                    .font(.system(size: 60))
                Text("Select a Photo")
            }
            .foregroundStyle(.gray)
        }
    }
    
    func reset() {
        selectedItem = nil
        selectedPhoto = nil
        selectedUIImage = nil
        newName = ""
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Person.self, inMemory: true)
}
