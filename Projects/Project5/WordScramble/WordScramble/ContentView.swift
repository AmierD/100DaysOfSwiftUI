//
//  ContentView.swift
//  WordScramble
//
//  Created by Amier Davis on 1/5/26.
//

import SwiftUI



struct ContentView: View {
    
    var body: some View {
        
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            
        }
        if let fileContents = try? String(contentsOf: fileURL) {
            
        }
        
        List {
            Section("Static rows") {
                Text("Static row")
                Text("Static row")
            }
            
            Section("Dynamic rows") {
                ForEach(0..<3) {
                    Text("Dynamic row \($0)")
                }
            }
            Text("Static row")
        }
        List(0..<5) {
            Text("Dynamic row \($0)")
        }
    }
}

#Preview {
    ContentView()
}
