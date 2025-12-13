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
    
    @FocusState private var amountIsFocused: Bool
    
    private var totalPerPerson: Double {
        let totalPer: Double = checkAmount / Double(numberOfPeople)
        let tipAmount: Double = 1.0 + Double(tipPercentage) / 100.0
        return totalPer * tipAmount
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
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Total Per Person") {
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
