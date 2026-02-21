//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Amier Davis on 1/14/26.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
