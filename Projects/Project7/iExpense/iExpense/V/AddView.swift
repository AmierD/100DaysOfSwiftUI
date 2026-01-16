//
//  AddView.swift
//  iExpense
//
//  Created by Amier Davis on 1/15/26.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var cost = 0.0
    
    @FocusState private var nameFieldIsFocused: Bool
    
    let types = ["Personal", "Business"]
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing: 50) {
                TextField("Enter name", text: $name)
                    .focused($nameFieldIsFocused)
                    .multilineTextAlignment(.center)
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
    }
    
    func addExpense() {
        let expense = ExpenseItem(name: name, type: type, cost: cost)
        expenses.items.append(expense)
        dismiss()
    }
}

#Preview {
    var expenses = Expenses()
    AddView(expenses: expenses)
}
