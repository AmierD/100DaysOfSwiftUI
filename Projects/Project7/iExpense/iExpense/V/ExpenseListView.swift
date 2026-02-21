//
//  ExpenseListView.swift
//  iExpense
//
//  Created by Amier Davis on 2/20/26.
//

import SwiftData
import SwiftUI

struct ExpenseListView: View {
    @Query var expenses: [ExpenseItem]
    
    @Environment(\.modelContext) private var modelContext
    
    init(filter: FilterOptions = .both, sortOrder: [SortDescriptor<ExpenseItem>]) {
        let filterString = filter.rawValue
        
        _expenses = Query(filter: #Predicate { expense in
            if filterString.isEmpty {
                return true
            } else {
                return expense.type.localizedStandardContains(filterString)
            }
        }, sort: sortOrder)
    }
    
    var body: some View {
        List {
            Section("Expenses") {
                ForEach(expenses) { item in
                    ExpenseItemView(item: item)
                }
                .onDelete(perform: removeItems)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let item = expenses[index]
            modelContext.delete(item)
        }
    }
}
