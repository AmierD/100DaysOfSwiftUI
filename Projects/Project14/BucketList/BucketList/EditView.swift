//
//  EditView.swift
//  BucketList
//
//  Created by Amier Davis on 3/5/26.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var vm: ViewModel
    
    var location: Location
    
    @State private var name: String
    @State private var description: String
    
    var onSave: (Location) -> Void
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        vm = ViewModel(location: location)
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby...") {
                    switch vm.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        
                        ForEach(vm.pages, id: \.pageid) { page in
                            let titleText = Text(page.title)
                                .font(.headline)
                            let descriptionText = Text(page.description)
                                .italic()
                            Text("\(titleText): \(descriptionText)")
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await vm.fetchNearbyPlaces()
            }
        }
    }
    
}

#Preview {
    EditView(location: .example) { _ in }
}
