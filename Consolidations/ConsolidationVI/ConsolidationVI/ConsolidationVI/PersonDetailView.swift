//
//  PersonDetailView.swift
//  ConsolidationVI
//
//  Created by Amier Davis on 5/24/26.
//

import SwiftUI

struct PersonDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var person: Person
    
    @State private var name: String
    
    init(person: Person) {
        self.person = person
        self.name = person.name
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                person.image!
                    .resizable()
                    .scaledToFit()
                TextField("Name", text: $name)
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
}
