//
//  ContentView.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var users: [User]
    
    var body: some View {
        VStack {
            UsersListView(users: users)
        }
        .task {
            if users.isEmpty {
                let newUsers = await APIService.fetchUsers()
                for user in newUsers {
                    modelContext.insert(user)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self)
}
