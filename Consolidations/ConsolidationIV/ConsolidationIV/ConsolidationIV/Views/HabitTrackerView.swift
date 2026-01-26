//
//  HabitTrackerView.swift
//  ConsolidationIV
//
//  Created by Amier Davis on 1/24/26.
//

import SwiftUI

struct HabitTrackerView: View {
    @Binding var viewModel: HabitTrackerViewModel
    @State private var showAddHabitSheet = false
    let rows: [GridItem] = [
        GridItem(.fixed(175)),
        GridItem(.fixed(175)),
        GridItem(.fixed(175))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.habits.isEmpty {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows, spacing: 0) {
                            ForEach($viewModel.habits) { $habit in
                                HabitView(viewModel: $viewModel, habit: $habit)
                                    
                            }
                        }
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(.hidden)
                    Spacer()
                } else {
                    Spacer()
                    HStack {
                        Text("Press the")
                        Image(systemName: "plus")
                        Text("to add a habit")
                    }
                    .foregroundStyle(.gray)
                    Spacer()
                    Spacer()
                    
                }
            }
                .navigationTitle("Habits")
                .sheet(isPresented: $showAddHabitSheet) {
                    AddHabitView(viewModel: $viewModel)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddHabitSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                viewModel.resetAllHabits()
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundStyle(.red)
                        }
                    }
                }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = HabitTrackerViewModel()
    HabitTrackerView(viewModel: $viewModel)
}
