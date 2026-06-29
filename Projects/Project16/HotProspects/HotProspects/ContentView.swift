//
//  ContentView.swift
//  HotProspects
//
//  Created by Amier Davis on 6/26/26.
//

import SwiftUI

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("One", systemImage: "star", value: "One") {
                selectionView
            }
            
            Tab("Two", systemImage: "circle", value: "Two") {
                Button("Show tab 1") {
                    selectedTab = "One"
                }
            }
            
        }
    }
    
    var selectionView: some View {
        NavigationStack {
            VStack {
                List(users, id: \.self, selection: $selection) { user in
                    Text(user)
                }
                if selection.isEmpty == false {
                    Text("You selected \(selection.formatted())")
                }
            }
            .toolbar {
                    EditButton()
            }
            
            Button("Show tab 2") {
                selectedTab = "Two"
            }
        }
    }
}

#Preview {
    ContentView()
}
