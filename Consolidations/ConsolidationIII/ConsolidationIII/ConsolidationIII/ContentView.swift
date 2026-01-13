//
//  ContentView.swift
//  ConsolidationIII
//
//  Created by Amier Davis on 1/10/26.
//

import SwiftUI

struct ContentView: View {
    @Namespace var namespace
    @State private var path = NavigationPath()
    
    @State var selectedTable = -1
    
    var questionAmounts = [10, 15, 20]
    @State var numQuestions = 10
    
    @State var difficulty = QuestionDifficulty.easy
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("Select question amount")
                    Picker("How many questions?", selection: $numQuestions) {
                        ForEach(questionAmounts, id: \.self) { option in
                            Text("\(option)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    Text("Select difficulty")
                    Picker("Difficulty", selection: $difficulty) {
                        ForEach(QuestionDifficulty.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    Spacer()
                    Text("Select times tables")
                    TableSelection(selectedTable: $selectedTable)
                        .padding()
                    Spacer()
                }
                Spacer()
                if selectedTable > -1 {
                    NavigationLink(value: selectedTable) {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                        .buttonStyle(.glassProminent)
                        .padding()
                        .ignoresSafeArea()
                }
            }
            .navigationDestination(for: Int.self) { table in
                TimesTable(
                    path: $path,
                    selectedTable: $selectedTable,
                    numQuestions: $numQuestions,
                    difficulty: $difficulty
                )
            }
        }
    }
}

enum QuestionDifficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

struct TimesTable: View {
    @Binding var path: NavigationPath
    
    @Binding var selectedTable: Int
    @Binding var numQuestions: Int
    @Binding var difficulty: QuestionDifficulty
    
    @State private var questionsCompleted = 0
    @State private var currentQuestion = 0
    @State private var roundComplete = false
    
    @State private var correctAnswer = 0
    @State private var userAnswer: Int? = nil
    
    @State private var numCorrect = 0
    
    @State private var answerState = AnswerState.unanswered
    
    @FocusState private var isNameFieldActive: Bool
    
    @State private var nextButtonVisible = false
    
    var currentColor = Color.red
    var background: some View {
        switch answerState {
        case .unanswered:
            LinearGradient(colors: [.white, .gray.opacity(0.25)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .correct:
            LinearGradient(colors: [.green, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .incorrect:
            LinearGradient(colors: [.red, .red.opacity(0.95)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        
    }
    
    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Text("\(selectedTable)")
                    Image(systemName: "plus")
                        .rotationEffect(Angle(degrees: 45))
                        .font(.subheadline)
                    Text("\(correctAnswer / selectedTable)")
                }
                .padding()
                .frame(width: 250)
                .background(.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .font(.largeTitle.weight(.bold))
                .animation(.spring(duration: 0.7), value: isNameFieldActive)
                HStack {
                    TextField(value: $userAnswer, format: .number) {
                        Text(isNameFieldActive ? "Enter answer" : "Click me")
                            .animation(.smooth, value: isNameFieldActive)
                    }
                    .focused($isNameFieldActive)
                    .multilineTextAlignment(.center)
                    .font(isNameFieldActive ? .title : .title.bold().scaled(by: 2))
                    .keyboardType(.numberPad)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button(role: .destructive) {
                                isNameFieldActive = false
                                handleAnswer()
                            } label: {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .onSubmit(handleAnswer)
                    .frame(width: 250, height: isNameFieldActive ? 100 : 250)
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .animation(.spring(duration: 0.7), value: isNameFieldActive)
                    .disabled(answerState != .unanswered)
                }
                Spacer()
                Spacer()
            }
            VStack {
                Spacer()
                if answerState != .unanswered && questionsCompleted < numQuestions {
                    Button("Next") {
                        withAnimation {
                            getNewQuestion()
                        }
                    }
                    .buttonStyle(.glass)
                }
            }
            .onAppear(perform: getNewQuestion)
            .alert("You got \(numCorrect) correct!", isPresented: $roundComplete) {
                Button("Exit to menu", role: .close) {
                    path = NavigationPath()
                }
                Button("Play again", action: reset)
            }
        }
    }
    
    enum AnswerState {
        case unanswered
        case correct
        case incorrect
    }
    
    func handleAnswer() {
        withAnimation {
            if userAnswer == correctAnswer {
                answerState = .correct
                numCorrect += 1
            } else {
                answerState = .incorrect
            }
        }
        
        questionsCompleted += 1
        
        if questionsCompleted >= numQuestions {
            roundComplete = true
        }
    }
    
    func getNewQuestion() {
        let lastAnswer = correctAnswer
        
        answerState = .unanswered
        userAnswer = nil
        
        while lastAnswer == correctAnswer {
            switch difficulty {
            case .easy:
                correctAnswer = selectedTable * Int.random(in: 1...5)
            case .medium:
                correctAnswer = selectedTable * Int.random(in: 2...10)
            case .hard:
                correctAnswer = selectedTable * Int.random(in: 3...12)
            }
        }
    }
    
    func reset() {
        numCorrect = 0
        questionsCompleted = 0
        getNewQuestion()
    }
}

struct TableSelection: View {
    @Binding var selectedTable: Int
    var body: some View {
        VStack {
            ForEach(0..<4) { i in
                HStack {
                    ForEach(2..<5) { j in
                        let number = j + (i * 3)
                        if number < 13 {
                            TableSelectionButton(
                                number: number,
                                pressedNumber: $selectedTable
                            )
                        }
                    }
                }
            }
        }
    }
}

struct TableSelectionButton: View {
    @State var number: Int
    @Binding var pressedNumber: Int
    
    @State private var isSelected: Bool = false
    
    let buttonSize = 80.0
    var body: some View {
        if isSelected {
            Button {
                withAnimation {
                    pressedNumber = number
                }
            } label: {
                Text("\(number)")
                    .font(.largeTitle)
                    .frame(maxWidth: buttonSize, maxHeight: buttonSize)
            }
            .buttonStyle(.glassProminent)
            .onChange(of: pressedNumber) {
                animate()
            }
        }
        else {
            Button {
                withAnimation {
                    pressedNumber = number
                }
            } label: {
                Text("\(number)")
                    .font(.largeTitle)
                    .frame(maxWidth: buttonSize, maxHeight: buttonSize)
            }
            .buttonStyle(.glass)
            .onChange(of: pressedNumber) {
                animate()
            }
        }
    }
    
    func animate() {
        withAnimation {
            if number == pressedNumber {
                isSelected = true
            } else {
                isSelected = false
            }
        }
    }
}

#Preview {
    ContentView()
}
