//
//  ContentView.swift
//  Unit Conversion
//
//  Created by Amier Davis on 12/13/25.
//

import SwiftUI

struct ContentView: View {
    @State private var input: Int = 0
    @State private var inputSelection: String = "Seconds"
    private let inputOptions = ["Seconds", "Minutes", "Hours", "Days"]
    private var currentInputOptionsIndex: Int {
        inputOptions.firstIndex(of: inputSelection) ?? 0
    }
    private var currentOutputOptionsIndex: Int {
        outputOptions.firstIndex(of: outputSelection) ?? 0
    }
    private var inputMultiplier: Int {
        switch inputSelection {
        case "Seconds": return 1
        case "Minutes": return 60
        case "Hours": return 3600
        case "Days": return 86400
        default: return 1
        }
    }
    
    private var outputMultiplier: Int {
        switch outputSelection {
        case "Seconds": return 1
        case "Minutes": return 60
        case "Hours": return 3600
        case "Days": return 86400
        default: return 1
        }
    }
    private var output: Int {
//        if currentInputOptionsIndex == currentOutputOptionsIndex {
//            return input
//        }
//        else if currentInputOptionsIndex < currentOutputOptionsIndex {
//            return input * outputMultiplier
//        }
//        else if currentInputOptionsIndex > currentOutputOptionsIndex {
//            return input * inputMultiplier / outputMultiplier
//        }
        return input * inputMultiplier / outputMultiplier
    }
    @State private var outputSelection: String = "Seconds"
    private let outputOptions = ["Seconds", "Minutes", "Hours", "Days"]
    
    var body: some View {
        NavigationStack {
            List {
                Section("From") {
                    Picker("From", selection: $inputSelection) {
                        ForEach(inputOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("From", value: $input, format: .number)
                }
                Section("To") {
                    Picker("To", selection: $outputSelection) {
                        ForEach(outputOptions, id: \.self) {
                            if $0 != inputSelection {
                                Text($0)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("\(output)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
