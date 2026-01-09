//
//  ContentView.swift
//  Animations
//
//  Created by Amier Davis on 1/7/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

#Preview {
    ContentView()
}

/* Transitions */
//VStack {
//    Button("Tap me") {
//        withAnimation {
//            isShowingRed.toggle()
//        }
//    }
//    
//    
//    if isShowingRed {
//        Rectangle()
//            .fill(.red)
//            .frame(width: 200, height: 200)
//            .transition(.asymmetric(insertion: .slide, removal: .scale))
//    }
//}

/* Gesure animations */
// @State private var dragAmount = CGSize.zero
//        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
//                    .frame(width: 300, height: 200)
//                    .clipShape(.rect(cornerRadius: 10))
//                    .offset(dragAmount)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { dragAmount = $0.translation }
//                            .onEnded { _ in dragAmount = .zero}
//                    )
//                    .animation(.bouncy, value: dragAmount)

/* Order of the implicit animation modifier matters: */
//        Button("Tap Me") {
//            enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? .red : .green)
//        .animation(nil, value: enabled)
//        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
//        .animation(.spring(duration: 0.4, bounce: 0.6), value: enabled)
