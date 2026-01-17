//
//  ContentView.swift
//  iExpense
//
//  Created by Amier Davis on 1/14/26.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var sheetIsPresented = false
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            ExpenseItemView(item: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            ExpenseItemView(item: item)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    withAnimation {
                        sheetIsPresented = true
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                AddView(expenses: expenses)
            }
            .navigationTitle("iExpense")
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
