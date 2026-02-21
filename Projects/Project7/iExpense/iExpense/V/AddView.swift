//
//  AddView.swift
//  iExpense
//
//  Created by Amier Davis on 1/15/26.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Binding var path: NavigationPath
    
    @State private var name = "Enter item name"
    @State private var type = "Personal"
    @State private var cost = 0.0
    
    @FocusState private var nameFieldIsFocused: Bool
    
    @Environment(\.modelContext) var modelContext
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing: 50) {
                TextField("Enter cost", value: $cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                Picker("Choose Personal or Business", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        HStack {
                            Image(systemName: type == "Personal" ? "person" : "briefcase")
                            Text("\(type)")
                        }
                    }
                }
            }
            Spacer()
            Button("Add Expense", action: addExpense)
                .buttonStyle(.bordered)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle($name)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", systemImage: "xmark") {
                    path = NavigationPath()
                }
            }
        }
    }
    
    func addExpense() {
        let expense = ExpenseItem(name: name, type: type, cost: cost)
        modelContext.insert(expense)
        path = NavigationPath()
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    AddView(path: $path)
        .modelContainer(for: ExpenseItem.self, inMemory: true)
}
