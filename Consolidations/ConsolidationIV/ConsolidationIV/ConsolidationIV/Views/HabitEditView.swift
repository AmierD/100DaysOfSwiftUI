//
//  HabitEditView.swift
//  ConsolidationIV
//
//  Created by Amier Davis on 1/25/26.
//

import SwiftUI

struct HabitEditView: View {
    @Binding var habitTitle: String
    @Binding var habitDescription: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Habit title:")
                TextField("Enter habit title...", text: $habitTitle)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            HStack {
                Text("Description:")
                Spacer()
            }
            ZStack {
                if habitDescription == "" {
                    HStack {
                        Text("Enter description...")
                            .foregroundStyle(.gray.opacity(0.4))
                            .padding(EdgeInsets(top: -75, leading: 19, bottom: 0, trailing: 0))
                        Spacer()
                    }
                }
                TextEditor(text: $habitDescription)
                    .padding()
                    .frame(height: 200)
                    .scrollContentBackground(.hidden)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .navigationTitle("New Habit")
            Spacer()
            Spacer()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var title = ""
    @Previewable @State var description = ""
    HabitEditView(habitTitle: $title, habitDescription: $description)
}
