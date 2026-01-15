//
//  ContentView.swift
//  iExpense
//
//  Created by Amier Davis on 1/14/26.
//

import SwiftUI
import Observation

class User: Codable {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct ContentView: View {
    @State private var user = User(firstName: "Amier", lastName: "Davis")
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @AppStorage("tapCount") private var tapCount = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Save User") {
                    let encoder = JSONEncoder()
                    
                    if let data = try? encoder.encode(user) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
                Text("\(tapCount)")
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                    tapCount += 1
                    UserDefaults.standard.set(tapCount, forKey: "tapCount")
                }
                Button("Show Sheet") {
                    showingSheet.toggle()
                }
                Text("Your name is \(user.firstName) \(user.lastName)")
                
                TextField("First name", text: $user.firstName)
                TextField("Last name", text: $user.lastName)
            }
            .toolbar {
                EditButton()
            }
        }
        .padding()
        .sheet(isPresented: $showingSheet) {
            SecondView(name: user.firstName)
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        Text("Your name is \(name)")
        Button("Dismiss") {
            dismiss()
        }
    }
}

#Preview {
    ContentView()
}
