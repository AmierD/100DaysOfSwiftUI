//
//  ContentView.swift
//  ConsolidationII
//
//  Created by Amier Davis on 1/3/26.
//

import SwiftUI

enum Choice: String, CaseIterable {
    case rock = "🪨"
    case paper = "📝"
    case scissors = "✂️"
}

struct ContentView: View {
    @State var computerChoice = Choice.allCases.randomElement() ?? .rock
    @State var playerShouldWin = Bool.random()
    
    @State var score = 0
    @State var currentQuestionCount = 0
    let maxQuestionCount = 10
    var gameShouldEnd: Bool {
        currentQuestionCount == maxQuestionCount
    }
    
    @State var showGameEndAlert = false
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 40) {
                Text("Score: \(score)")
                VStack(spacing: 20) {
                    Text("Computer plays \(computerChoice.rawValue)")
                    Text(
                        playerShouldWin ?
                        "You should win." : "You should lose."
                    )
                }
            }
            Spacer()
            HStack {
                ForEach(Choice.allCases, id: \.self) { choice in
                    Button(action: {
                        handlePlayerChoice(choice)
                        if currentQuestionCount < maxQuestionCount {
                            randomize()
                        }
                    }) {
                        ZStack {
                            Color.blue
                            Text(choice.rawValue)
                        }
                        .clipShape(.capsule)
                        .frame(width: 90, height: 75)
                        .padding(10)
                        
                    }
                }
            }
            Spacer()
        }
        .padding()
        .onChange(of: gameShouldEnd) {
            if gameShouldEnd {
                showGameEndAlert = true
            }
        }
        .alert("Game Over", isPresented: $showGameEndAlert) {
            Button("Restart") {
                score = 0
                currentQuestionCount = 0
                randomize()
            }
        }
    }
    
    func handlePlayerChoice(_ choice: Choice) {
        currentQuestionCount += 1
        
        guard choice != computerChoice else { return }
        
        var playerWin: Bool
        
        switch choice {
        case .paper:
            if computerChoice == .rock {
                playerWin = true
            } else {
                playerWin = false
            }
        case .rock:
            if computerChoice == .scissors {
                playerWin = true
            } else {
                playerWin = false
            }
        case .scissors:
            if computerChoice == .paper {
                playerWin = true
            } else {
                playerWin = false
            }
        }
        
        if playerWin == playerShouldWin {
            score += 1
        }
    }
    
    func randomize() {
        computerChoice = .allCases.randomElement()!
        playerShouldWin.toggle()
    }
}

#Preview {
    ContentView()
}
