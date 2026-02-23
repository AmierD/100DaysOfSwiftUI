//
//  ContentView.swift
//  Instafilter
//
//  Created by Amier Davis on 2/23/26.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    @State private var showingConfirmation = false
    @State private var backgroundColor: Color = .white
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { oldValue, newValue in
                    print("New value is \(blurAmount)")
                }
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
            
            Button("Change Background") {
                showingConfirmation = true
            }
            .confirmationDialog("Change Background", isPresented: $showingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Red") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color.")
            }
            .frame(width: 300, height: 300)
            .background(backgroundColor)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
