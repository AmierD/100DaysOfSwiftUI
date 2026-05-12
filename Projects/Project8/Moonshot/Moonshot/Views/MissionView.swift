//
//  MissionView.swift
//  Moonshot
//
//  Created by Amier Davis on 1/19/26.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember: Hashable {
        let role: String
        let astronaut: Astronaut
    }
    var mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.6
                    }
                    .accessibilityHidden(true)
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    Text(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "")
                        .accessibilityLabel("Mission launch date, \(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "")")
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                        .accessibilityHidden(false)
                    Text(mission.description)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                        .accessibilityHidden(false)
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                MissionAstronautScroll(crew: crew)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    MissionView(mission: missions[2], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
