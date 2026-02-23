//
//  UsersListView.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import SwiftData
import SwiftUI

struct UsersListView: View {
    @Environment(\.modelContext) private var modelContext
    
    let users: [User]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(users) { user in
                        NavigationLink(value: user) {
                            UserView(user: user)
                                .foregroundStyle(.black)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .navigationDestination(for: User.self) { user in
                    UserDetailView(user: user)
                }
            }
            
        }
        
    }
}
