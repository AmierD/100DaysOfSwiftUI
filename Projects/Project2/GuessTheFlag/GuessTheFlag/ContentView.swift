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
    @State private var showingScore = false
    @State private var scoreTitle = " "
    @State private var isAnswerCorrect = false
    
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
                        Image(countries[number])
                            .shadow(radius: 5)
                    }
                }
                Spacer()
                Spacer()
                Text("Score: ???")
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Play again", action: askQuestion)
        } message: {
            Text("Your score is ???")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            isAnswerCorrect = true
        } else {
            scoreTitle = "Incorrect"
            isAnswerCorrect = false
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        scoreTitle = " "
        isAnswerCorrect = false
    }
}

#Preview {
    ContentView()
}
