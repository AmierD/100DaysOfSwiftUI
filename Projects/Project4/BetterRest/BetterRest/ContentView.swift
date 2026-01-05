//
//  ContentView.swift
//  BetterRest
//
//  Created by Amier Davis on 1/4/26.
//

import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date {
        var componenets = DateComponents()
        componenets.hour = 7
        componenets.second = 0
        return Calendar.current.date(from: componenets) ?? .now
    }
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .center) {
                    Text("Wake up time")
                        .font(.headline)
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute
                    )
                        .labelsHidden()
                }
                .frame(maxWidth: .infinity)
                .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                VStack {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                VStack {
                    Text("How much coffee")
                        .font(.headline)
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                }
//                Text("Sleep time: \()")
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            // reads in all data and outputs a prediction:
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents(
                [.hour, .second],
                from: wakeUp
            )
            let hour = (components.hour ?? 0) * 60 * 60
            let seconds = (components.second ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(hour + seconds),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Calculated sleep time"
            alertMessage = "\(sleepTime.formatted(date: .omitted, time: .shortened))"
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calcuating your bedtime."
        }
        
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
