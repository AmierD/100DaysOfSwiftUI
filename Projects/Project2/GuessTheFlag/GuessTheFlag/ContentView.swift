//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Amier Davis on 12/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Spain",
        "UK",
        "Ukraine",
        "US"
    ]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0..<3)
    @State private var showingScoreAlert = false
    @State private var scoreTitle = " "
    @State private var isAnswerCorrect = false
    @State private var score = 0
    @State private var highScore = 0
    @State private var countQuestions = 0
    @State private var showingGameEndAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .indigo],
                startPoint: .bottom,
                endPoint: .top
            )
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                VStack() {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.semibold))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.heavy))
                }
                Spacer()
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        FlagImage(item: countries[number])
                    }
                }
                Spacer()
                Spacer()
                VStack {
                    Text("Score: \(score)")
                    Text("High score: \(highScore)")
                }
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScoreAlert) {
            Button("Play again", action: showNewFlags)
        } message: {
            Text("Score: \(score)")
        }
        .alert("Game over", isPresented: $showingGameEndAlert) {
            Button(
                highScore == 8 ? "You win!" : "Start over",
                action: resetGame
            )
        } message: {
            Text("Your high score: \(highScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            isAnswerCorrect = true
            score += 1
            showNewFlags()
        } else {
            scoreTitle = "Incorrect. That was \(countries[number])"
            isAnswerCorrect = false
            showingScoreAlert = true
            
        }
        handleHighScore()
        countQuestions += 1
        
        if countQuestions == 8 {
            showingGameEndAlert = true
        }
    }
    
    func showNewFlags() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if scoreTitle.hasPrefix("Incorrect") {
            score = 0
        }
        isAnswerCorrect = false
    }
    
    func handleHighScore() {
        if score > highScore {
            highScore = score
        }
    }
    
    func resetGame() {
        countQuestions = 0
        score = 0
        highScore = 0
        showNewFlags()
    }
}

struct FlagImage: View {
    var item: String
    
    var body: some View {
        Image(item)
            .shadow(radius: 5)
    }
}

struct LargeBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

#Preview {
    ContentView()
}
