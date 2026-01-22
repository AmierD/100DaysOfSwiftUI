//
//  ContentView.swift
//  Navigation
//
//  Created by Amier Davis on 1/21/26.
//

import SwiftUI

@Observable
// code allowing us to save the current path of the user so it persists when they reopen the app
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            List {
                ForEach(0..<5) { i in
                    NavigationLink("Go to \(i)", value: i)
                }
                ForEach(0..<5) { i in
                    NavigationLink("Go to Amier\(i)", value: "Amier\(i)")
                }
            }
            .toolbar {
                Button("append 556"){
                    pathStore.path.append(556)
                }
                Button("Hello"){
                    pathStore.path.append("Hello")
                }
            }
            .navigationDestination(for: Int.self) { selection in
                DetailView(path: $pathStore.path, selection: selection)
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

struct DetailView: View {
    @Binding var path: NavigationPath
    var selection: Int
    let random = Int.random(in: 1...500)
    var body: some View {
        VStack {
            Text("You selected \(selection)")
            Button("append \(random)"){
                path.append(random)
            }
        }
        .toolbar {
            Button("Home", systemImage: "house") {
                path = NavigationPath()
            }
        }
    }
}
/* Path as an array of primitives
 @State var path = [Int]()
 
 NavigationStack(path: $path) {
     VStack {
         Image(systemName: "globe")
             .imageScale(.large)
             .foregroundStyle(.tint)
         Text("Hello, world!")
         Button("Show 32") {
             path = [32, 64] // updates the path to only include 32 and 64
         }
         Button("Show 64") {
             path.append(64)
         }
     }
     .navigationDestination(for: Int.self) { selection in
         VStack {
             Text("You selected \(selection)")
             Button("Show 64") {
                 path.append(64) // adds 64 to the existing path
             }
             Button("Show 32") {
                 path = [32] // updates the path to only include 32, all other values will be removed
             }
         }
     }
 }
 
 */

#Preview {
    ContentView()
}
