//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
