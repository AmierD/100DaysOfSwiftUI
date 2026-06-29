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
    
    @State private var selectedTab = "Three"
    
    @State private var output = ""
    
    enum BackgroundColors: String {
        case red = "Red"
        case orange = "Orange"
        case green = "Green"
        
        var color: Color {
            switch self {
            case .red: return .red
            case .orange: return .orange
            case .green: return .green
            }
        }
    }
    
    @State private var backgroundColor: BackgroundColors = .red
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("One", systemImage: "star", value: "One") {
                selectionView
            }
            
            Tab("Two", systemImage: "circle", value: "Two") {
                resultView
                Button("Show tab 1") {
                    selectedTab = "One"
                }
            }
            
            Tab("Three", systemImage: "square", value: "Three") {
                imgInterpolationView
            }
            
            Tab("Context", systemImage: "square", value: "Context") {
                contextMenuView
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
    
    var resultView: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    
    var imgInterpolationView: some View {
        Image(.example)
            .interpolation(.none) // allows image to retain pixellated look
            .resizable()
            .scaledToFit()
            .background(.black)
    }
    
    var contextMenuView: some View {
        VStack {
            Text("Hello World")
                .padding()
                .background(backgroundColor.color)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Red", systemImage: getSysImg("Red")) {
                        backgroundColor = .red
                    }
                    Button("Orange", systemImage: getSysImg("Orange")) {
                        backgroundColor = .orange
                    }
                    Button("Green", systemImage: getSysImg("Green")) {
                        backgroundColor = .green
                    }
                }
        }
    }
    
    func getSysImg(_ str: String) -> String {
        if str == backgroundColor.rawValue {
            "checkmark.circle.fill"
        } else {
            "circle"
        }
    }
    
    func fetchReadings() async {
//        do {
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let readings = try JSONDecoder().decode([Double].self, from: data)
//            output = "Found \(readings.count) readings"
//        } catch {
//            print("Download error")
//        }
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        switch result {
        case .success(let str):
            output = str
        case .failure(let error):
            output = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
