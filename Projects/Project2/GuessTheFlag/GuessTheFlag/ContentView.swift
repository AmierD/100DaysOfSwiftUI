//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Amier Davis on 12/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        ZStack {
            VStack {
                Text("Hello, World!")
                Button("Edit", systemImage: "pencil", action: executeDelete)
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                Button("Show Alert") {
                    showingAlert.toggle()
                }
                .alert("Important message", isPresented: $showingAlert) {
                    Button("Delete", role: .destructive) { }
                } message: {
                    Text("Please read me")
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func executeDelete() {
        print("Delete")
    }
}

#Preview {
    ContentView()
}
