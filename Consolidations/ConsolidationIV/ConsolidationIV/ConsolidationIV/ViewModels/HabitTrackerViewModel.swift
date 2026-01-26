//
//  HabitTrackerViewModel.swift
//  ConsolidationIV
//
//  Created by Amier Davis on 1/24/26.
//

import SwiftUI

@Observable
class HabitTrackerViewModel {
    // TODO: add functionality to initialize this as the user default habit array
    private let savePath = URL.documentsDirectory.appending(path: "savePath")
    var habits: [Habit] {
        didSet {
            save()
        }
    }
    
    var sortedHabits: [Habit] {
            habits.sorted { lhs, rhs in
                if lhs.completed == rhs.completed {
                    return false
                }
                return !lhs.completed
            }
        }
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
                self.habits = decoded
                return
            }
        }
        
        self.habits = [Habit]()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(habits)
            try data.write(to: savePath)
        } catch {
            
        }
    }
    
    func resetAllHabits() {
        habits = habits.map { habit in
            var tempHabit = habit
            tempHabit.completed = false
            return tempHabit
        }
    }
}
