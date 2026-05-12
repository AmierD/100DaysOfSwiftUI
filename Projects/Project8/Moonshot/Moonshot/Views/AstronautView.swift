//
//  AstronautView.swift
//  Moonshot
//
//  Created by Amier Davis on 1/19/26.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .accessibilityHidden(true)
                
                Text(astronaut.description)
                    .padding()
                    .accessibilityLabel("Astronaut description")
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    AstronautView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
