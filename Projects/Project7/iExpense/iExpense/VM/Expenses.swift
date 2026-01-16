//
//  Expenses.swift
//  iExpense
//
//  Created by Amier Davis on 1/15/26.
//

import Foundation
import Observation

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
            
            items = []
        }
        else {
            items = []
        }
    }
}
