//
//  ContentView.swift
//  Navigation
//
//  Created by Amier Davis on 1/21/26.
//

import SwiftUI

struct Student: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var age: Int
}

struct ContentView: View {
    var students: [Student] = [
        Student(name: "amier", age: 19),
        Student(name: "j", age: 20)
    ]
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                // loads the views inside the link with the parent Nav Stack
                NavigationLink("Tap me") {
                    DetailView(number: 5)
                }
                
                // using a navLink paired with a navDestination leads the views as they are needed
                List(students) { student in
                    NavigationLink("Select \(student.name)", value: student)
                }
                // you can have multiple nav destinations
                .navigationDestination(for: Student.self) { selection in
                    Text("You selected \(selection.age)")
                }
            }
            .padding()
        }
    }
}

struct DetailView: View {
    var number: Int
    
    var body: some View {
        Text("Detail view \(number)")
    }
    
    init(number: Int) {
        self.number = number
        print("Creating detail view \(number)")
    }
}

#Preview {
    ContentView()
}
