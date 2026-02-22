//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        VStack {
            Text("Company: \(user.company)")
            Text("Registered: \(user.registered.formatted(date: .abbreviated, time: .omitted))")
            Text("About: \(user.about)")
        }
        .navigationTitle(user.name)
    }
}

#Preview {
    UserDetailView(user: User.sample)
}
