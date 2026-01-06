//
//  ContentView.swift
//  WordScramble
//
//  Created by Amier Davis on 1/5/26.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .onSubmit(addNewWord)
                        .textInputAutocapitalization(.never)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                Button("New Word") {
                    startGame()
                }
            }
            Text("Score: \(score)")
                .font(.largeTitle.bold())
        }
        // runs when the view is shown
        .onAppear(perform: startGame)
        .alert (errorTitle, isPresented: $showingError) {
            
        } message: {
            Text(errorMessage)
        }
    }
    
    func startGame() {
        // find URL for start.txt in app bundle
        withAnimation {
            usedWords = []
            score = 0
        }
        if let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) {
            // load start.txt into a string
            if let startWords = try? String(
                contentsOf: startWordsURL,
                encoding: .ascii
            ) {
                // split the string into an array of strings
                let allWords: [String] = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "abrasion"
                
                return
            }
        }
        
        // if this code runs, there was a problem
        // this code will trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isWord(answer) else {
            wordError(title: "Word not a word", message: "Did you make that up?")
            return
        }
        guard isNotRootWord(answer) else {
            wordError(title: "Word same as root word", message: "Be more original")
            return
        }
        guard isGreaterThan2Letters(answer) else {
            wordError(
                title: "Word shorter than 3 letters",
                message: "Give a longer word"
            )
            return
        }
        guard isOriginal(answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isPossible(answer) else {
            wordError(title: "Word not possible", message: "Look at the word again")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: usedWords.count)
        }
        handleScore(answer)
        newWord = ""
    }
    
    func isWord(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isNotRootWord(_ word: String) -> Bool {
        word != rootWord
    }
    
    func isGreaterThan2Letters(_ word: String) -> Bool {
        word.count > 2
    }
    
    func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(_ word: String) -> Bool {
        var rootCopy = rootWord
        for letter in word {
            if let position = rootCopy.firstIndex(of: letter) {
                rootCopy.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func handleScore(_ word: String) {
        score += word.count * 10
    }
}

#Preview {
    ContentView()
}
