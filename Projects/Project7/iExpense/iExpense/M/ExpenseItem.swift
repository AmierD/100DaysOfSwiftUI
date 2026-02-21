//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Amier Davis on 1/15/26.
//

import Foundation
import SwiftData

@Model
class ExpenseItem {
    var id = UUID()
    var name: String
    var type: String
    var cost: Double
    
    init(id: UUID = UUID(), name: String, type: String, cost: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.cost = cost
    }
}

enum FilterOptions: String, CaseIterable {
    case personal = "Personal"
    case business = "Business"
    case both = ""
}

//MARK: - Extensions
extension ExpenseItem {
    static var sampleArray = [
        ExpenseItem(name: "Airfaire", type: "Business", cost: 500.0),
        ExpenseItem(name: "Valorant Points", type: "Personal", cost: 25.0)
    ]
}
