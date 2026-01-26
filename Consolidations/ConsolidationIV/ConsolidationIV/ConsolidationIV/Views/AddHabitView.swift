//
//  AddHabitView.swift
//  ConsolidationIV
//
//  Created by Amier Davis on 1/24/26.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var viewModel: HabitTrackerViewModel
    @State private var habitTitle: String = ""
    @State private var habitDescription: String = ""
    @State private var emptyTitleAlert = false
    @State private var habitAddedAlert = false
    var body: some View {
        NavigationStack {
            HabitEditView(habitTitle: $habitTitle, habitDescription: $habitDescription)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: addHabit) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .foregroundStyle(.red)
                }
            }
            .alert("Please enter a title.", isPresented: $emptyTitleAlert) { }
            .alert("Successfully added habit.", isPresented: $habitAddedAlert) {
                Button(action: exitView) {
                    Text("Ok")
                }
            }
            .sensoryFeedback(.warning, trigger: emptyTitleAlert)
        }
    }
    
    func addHabit() {
        if habitTitle.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            viewModel.habits.append(Habit(title: habitTitle, description: habitDescription))
            habitAddedAlert = true
        } else {
            emptyTitleAlert = true
        }
    }
    func exitView() {
        dismiss()
    }
}

#Preview {
    @Previewable @State var viewModel = HabitTrackerViewModel()
    AddHabitView(viewModel: $viewModel)
}
