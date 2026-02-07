//
//  AddBookView.swift
//  Bookworm
//
//  Created by Amier Davis on 2/3/26.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    private var isValid: Bool {
        let titleEmpty = title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let authorEmpty = author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return !titleEmpty && !authorEmpty
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author of book", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    HStack {
                        Spacer()
                        RatingView(rating: $rating)
                        Spacer()
                    }
                }
                
                Section {
                    Button("Save", action: saveBook)
                        .disabled(!isValid)
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func saveBook() {
        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
        modelContext.insert(newBook)
        dismiss()
    }
}

#Preview {
    AddBookView()
        .modelContainer(for: Book.self)
}
