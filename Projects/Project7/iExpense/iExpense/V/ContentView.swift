//
//  ContentView.swift
//  iExpense
//
//  Created by Amier Davis on 1/14/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    //    @State private var expenses = Expenses()
    @Query var expenses: [ExpenseItem]
    @State private var path = NavigationPath()
    @Environment(\.modelContext) private var modelContext
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.cost, order: .reverse),
        SortDescriptor(\ExpenseItem.name)
    ]
    @State private var filter: FilterOptions = .both
    private var filterText: String {
        filter == .business || filter == .personal ? filter.rawValue : "Both"
    }
    @State private var cycleFilters = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ExpenseListView(filter: filter, sortOrder: sortOrder)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    path.append(1)
                }
                Button(filterText) { cycleFilters.toggle() }
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Cost")
                            .tag([
                                SortDescriptor(\ExpenseItem.cost, order: .reverse),
                                SortDescriptor(\ExpenseItem.name)
                            ])
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.cost, order: .reverse)
                            ])
                    }
                }
            }
            .navigationDestination(for: Int.self) { _ in
                AddView(path: $path)
            }
            .navigationTitle("iExpense")
            .onChange(of: cycleFilters) {
                if filter == .both {
                    filter = .personal
                } else if filter == .personal {
                    filter = .business
                } else {
                    filter = .both
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self, inMemory: true)
}
