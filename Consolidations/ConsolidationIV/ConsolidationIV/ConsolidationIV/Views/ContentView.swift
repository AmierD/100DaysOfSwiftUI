//
//  ContentView.swift
//  ConsolidationIV
//
//  Created by Amier Davis on 1/24/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = HabitTrackerViewModel()
    var body: some View {
        TabView {
            Tab("Habits", systemImage: "house") {
                HabitTrackerView(viewModel: $viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
