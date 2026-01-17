//
//  ExpenseItemView.swift
//  iExpense
//
//  Created by Amier Davis on 1/16/26.
//

import SwiftUI

struct ExpenseItemView: View {
    let item: ExpenseItem
    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            if item.cost < 10.0 {
                Text(item.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .background(.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 5))
            } else if item.cost < 100.0 {
                Text(item.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .background(.yellow.opacity(0.6), in: RoundedRectangle(cornerRadius: 5))
            } else {
                Text(item.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .background(.red.opacity(0.8), in: RoundedRectangle(cornerRadius: 5))
            }
            Image(systemName: item.type == "Personal" ? "person" : "briefcase")
        }
    }
}
