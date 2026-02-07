//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Amier Davis on 2/7/26.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
