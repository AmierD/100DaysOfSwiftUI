//
//  Habit.swift
//  ConsolidationIV
//
//  Created by Amier Davis on 1/24/26.
//

import SwiftUI

struct Habit: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var completed: Bool = false
}

extension Habit {
    static var sample = Habit(title: "Go to the gym", description: "I want to complete this habit daily")
    static var samples = [
        Habit(title: "Go to gym1", description: "I want to complete this habit daily"),
        Habit(title: "Go to gym", description: "I want to complete this habit daily"),
        Habit(title: "Go to gym", description: "I want to complete this habit daily"),
        Habit(title: "Go to gym", description: "I want to complete this habit daily"),
        Habit(title: "Go to gym", description: "I want to complete this habit daily"),
        Habit(title: "Go to gym", description: "I want to complete this habit daily"),
        Habit(title: "Go to gym", description: "I want to complete this habit daily"),
        Habit(title: "Go to gym", description: "I want to complete this habit daily")
    ]
}
