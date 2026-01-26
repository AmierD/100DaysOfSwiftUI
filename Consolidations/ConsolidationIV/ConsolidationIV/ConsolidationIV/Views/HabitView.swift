//
//  HabitView.swift
//  ConsolidationIV
//
//  Created by Amier Davis on 1/24/26.
//

import SwiftUI

struct HabitView: View {
    @Binding var viewModel: HabitTrackerViewModel
    @Binding var habit: Habit
    @State private var widthAnimation: CGFloat = .infinity
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .frame(width: 150, height: 150)
//                .foregroundStyle(LinearGradient(colors: [.blue.opacity(0.4), .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundStyle(.gray.opacity(0.4))
            VStack {
                VStack(spacing: 5) {
                    Text(habit.title)
                        .frame(width: 100)
                        .multilineTextAlignment(.leading)
                        .font(.subheadline.bold())
                    Text(habit.description)
                        .frame(width: 100)
                        .multilineTextAlignment(.leading)
                        .font(.caption2)
                }
                Spacer()
                Group {
                    ZStack {
                        Capsule()
                            .frame(width: widthAnimation, height: 50)
                        Image(systemName: habit.completed ? "checkmark" : "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(habit.completed ? .green : .red)
                            .font(.title.weight(.black))
                            .animation(.bouncy, value: habit.completed)
                    }
                }
                .onTapGesture {
                    if widthAnimation == .infinity {
                        withAnimation(.spring(duration: 0.25)) {
                            habit.completed.toggle()
                            widthAnimation = 50
                        } completion: {
                            withAnimation(.spring(duration: 0.3)) {
                                widthAnimation = .infinity
                                viewModel.habits = viewModel.sortedHabits
                            }
                        }
                    }
                }
                .sensoryFeedback(.selection, trigger: habit.completed)
            }
            .padding(15)
        }
        .foregroundStyle(.black)
        .padding()
        .contextMenu {
            Button("Delete", systemImage: "trash", role: .destructive) {
                withAnimation(.spring(bounce: 0.3)) {
                    deleteHabit(habit)
                }
            }
            NavigationLink(destination: HabitDetailView(habit: $habit)) {
                Text("Edit")
                Image(systemName: "pencil")
            }
        }
        .frame(width: 150, height: 150)
        .padding()
    }
    
    func deleteHabit(_ habit: Habit) {
        viewModel.habits.remove(at: viewModel.habits.firstIndex(where: { $0.id == habit.id})!)
    }
}

#Preview {
    @Previewable @State var viewModel = HabitTrackerViewModel()
    @Previewable @State var habit = Habit.sample
    HabitView(viewModel: $viewModel, habit: $habit)
}
