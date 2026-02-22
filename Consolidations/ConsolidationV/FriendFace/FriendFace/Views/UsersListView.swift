//
//  UsersListView.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import SwiftUI

struct UsersListView: View {
    @Environment(UsersViewModel.self) private var vm
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(vm.users) { user in
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
