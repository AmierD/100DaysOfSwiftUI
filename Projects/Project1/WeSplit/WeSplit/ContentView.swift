//
//  ContentView.swift
//  WeSplit
//
//  Created by Amier Davis on 12/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    let students = ["Amier", "John", "Sally"]
    @State var currentStudent = "Amier"
    var body: some View {
        Text("Hello, world!")
    }
}

#Preview {
    ContentView()
}
