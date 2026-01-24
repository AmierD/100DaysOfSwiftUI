//
//  ContentView.swift
//  Moonshot
//
//  Created by Amier Davis on 1/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    enum MissionLayout {
        case grid, list
    }
    
    @State private var missionLayout = MissionLayout.grid
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if missionLayout == .grid {
                    MissionGridLayout(astronauts: astronauts, missions: missions)
                } else {
                    MissionListLayout(astronauts: astronauts, missions: missions)
                }
            }
                .navigationTitle("Moonshot")
                .toolbar {
                    ToolbarItem {
                        Button("", systemImage: missionLayout == .grid ? "rectangle.grid.1x3" : "square.grid.2x2") {
                            withAnimation(.spring) {
                                if missionLayout == .grid {
                                    missionLayout = .list
                                } else {
                                    missionLayout = .grid
                                }
                            }
                        }
                    }
                }
                .preferredColorScheme(.dark)
                .background(.darkBackground)
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
                .navigationDestination(for: MissionView.CrewMember.self) { crewMember in
                    AstronautView(astronaut: crewMember.astronaut)
                }
        }
    }
}

struct MissionGridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
    }
}

struct MissionListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
            }
            .padding([.horizontal, .bottom])
        }
        .listStyle(.plain)
    }
}


#Preview {
    ContentView()
}
