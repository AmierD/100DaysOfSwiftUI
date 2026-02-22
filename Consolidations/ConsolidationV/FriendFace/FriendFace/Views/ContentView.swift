//
//  ContentView.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(UsersViewModel.self) var vm
    
    var body: some View {
        VStack {
            UsersListView()
        }
        .task {
            await vm.fetchUsers()
        }

    }
}

#Preview {
    ContentView()
        .environment(UsersViewModel())
}
