//
//  ContentView.swift
//  Bookworm
//
//  Created by Amier Davis on 2/2/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var books: [Book]
    
    @State private var showingAddBook = false
    
    var body: some View {
        NavigationStack {
            List(books) { book in
                NavigationLink(value: book) {
                    HStack {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            Text(book.author)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
                .sheet(isPresented: $showingAddBook) {
                    AddBookView()
                }
                .toolbar {
                    ToolbarItem {
                        Button("Add") {
                            showingAddBook = true
                        }
                    }
                }
                .navigationTitle("Bookworm")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Book.self)
}
