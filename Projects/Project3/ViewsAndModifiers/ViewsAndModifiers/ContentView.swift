//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Amier Davis on 12/31/25.
//

/* Custom Views, Modifiers, and Containers, */

import SwiftUI

struct ContentView: View {
    @State private var showRed = false
    
    /* Custom View */
    // @ViewBuilder allows us to put multiple views here
    @ViewBuilder var motto1: some View {
        Text("An apple a day keeps the doctor away.")
        Text("An apple a day keeps the doctor away.")
    }
    
    // @ViewBuilder is implicit in body parameter of a view
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundStyle(showRed ? .red : .black)
            Button(showRed ? "Turn red off" : "Turn red on") {
                showRed.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(.green)
        .padding()
        .background(.white)
        .padding()
        .background(.green)
        VStack {
            CapsuleView(text: "Gryffindor")
                .watermarked(with: "Amier")
            CapsuleView(text: "Hufflepuff")
                .foregroundStyle(.black)
            Text("Ravenclaw")
            Text("Slytherin")
            motto1
                .font(.title.weight(.semibold))
            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Image(systemName: "\(row * 4 + col).circle")
            }
        }
        .font(.title.weight(.black))
        
    }
}

struct CapsuleView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .titleStyle()
    }
}

/* Custom Modifier */
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

/* Custom Modifier */
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

/* Custom Container */
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        ForEach(0..<rows, id: \.self) { row in
            HStack {
                ForEach(0..<columns, id: \.self) { column in
                    content(row, column)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
