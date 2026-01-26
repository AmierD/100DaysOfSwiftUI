//
//  HabitView.swift
//  ConsolidationIV
//
//  Created by Amier Davis on 1/24/26.
//

import SwiftUI
import Combine

struct HabitDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var habit: Habit
    @State private var newHabitTitle: String
    @State private var newHabitDescription: String
    @State private var emptyTitleAlert: Bool
    @State private var habitEditedAlert: Bool
    
    init(habit: Binding<Habit>) {
        self._habit = habit
        self.newHabitTitle = habit.title.wrappedValue
        self.newHabitDescription = habit.description.wrappedValue
        self.emptyTitleAlert = false
        self.habitEditedAlert = false
    }
    
    var body: some View {
        HabitEditView(habitTitle: $newHabitTitle, habitDescription: $newHabitDescription)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: addHabit) {
                    Image(systemName: "plus")
                }
            }
        }
        .alert("Please enter a title.", isPresented: $emptyTitleAlert) { }
        .alert("Successfully edited habit.", isPresented: $habitEditedAlert) {
            Button("Ok", action: exitView)
        }
        .sensoryFeedback(.warning, trigger: emptyTitleAlert)
    }
    
    func addHabit() {
        let newTitleDifferentThanOld = newHabitTitle != habit.title
        let newDescriptionDifferentThanOld = newHabitDescription != habit.description
        
        guard newTitleDifferentThanOld || newDescriptionDifferentThanOld else {
            dismiss()
            return
        }
        guard newHabitTitle.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            emptyTitleAlert = true
            return
        }
        
        habit.title = newHabitTitle
        habit.description = newHabitDescription
        habitEditedAlert = true
    }
    
    func exitView() {
        dismiss()
    }
}

#Preview {
    @Previewable @State var habit = Habit.sample
    HabitDetailView(habit: $habit)
}
