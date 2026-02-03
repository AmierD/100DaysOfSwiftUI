//
//  ContentView.swift
//  Bookworm
//
//  Created by Amier Davis on 2/2/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student]
    
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text(student.name)
                    
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add", systemImage: "plus") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    let fullName = "\(chosenFirstName) \(chosenLastName)"
                    
                    let student = Student(id: UUID(), name: fullName)
                    
                    modelContext.insert(student)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Student.self, inMemory: true)
}
