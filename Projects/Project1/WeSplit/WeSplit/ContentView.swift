//
//  ContentView.swift
//  WeSplit
//
//  Created by Amier Davis on 12/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    private var tipAmount: Double {
        1.0 + Double(tipPercentage) / 100.0
    }
    private var checkWithTip: Double {
        checkAmount * tipAmount
    }
    
    @FocusState private var amountIsFocused: Bool
    
    private var totalPerPerson: Double {
        let subTotalPer: Double = checkAmount / Double(numberOfPeople)
        return subTotalPer * tipAmount
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var body: some View {
        NavigationStack {
            Form {
                Section("Payment Info") {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(
                            // locale has all the user's region settings
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(0..<10) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("Tip Percentage") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Total Check") {
                    Text(checkWithTip,
                         format:
                            .currency(
                                code: Locale
                                    .current
                                    .currency?
                                    .identifier ?? "USD"
                    
                            )
                    )
                    .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
                Section("Amount Per Person") {
                    Text(
                        totalPerPerson,
                        format: .currency(
                            code: Locale
                                .current
                                .currency?
                                .identifier ?? "USD"
                        )
                    )
                }
            }
            
            .navigationTitle(Text("WeSplit"))
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
