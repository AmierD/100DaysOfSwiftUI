//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Amier Davis on 1/15/26.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let cost: Double
}
