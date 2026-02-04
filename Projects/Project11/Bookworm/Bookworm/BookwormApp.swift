//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Amier Davis on 2/2/26.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
