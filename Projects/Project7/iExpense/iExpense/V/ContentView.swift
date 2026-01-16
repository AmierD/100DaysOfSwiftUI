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
                ForEach(expenses.items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text(item.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        Image(systemName: item.type == "Personal" ? "person" : "briefcase")
                    }
                }
                .onDelete(perform: removeItems)
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
