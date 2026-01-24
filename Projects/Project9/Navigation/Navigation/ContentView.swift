//
//  ContentView.swift
//  Navigation
//
//  Created by Amier Davis on 1/21/26.
//

import SwiftUI

struct ContentView: View {
    @State private var title = "SwiftUI"
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarBackground(.white)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Tap me") { }
                    Button("Tap me too") { }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
