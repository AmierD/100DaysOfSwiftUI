//
//  ConsolidationVIApp.swift
//  ConsolidationVI
//
//  Created by Amier Davis on 5/24/26.
//

import SwiftUI
import SwiftData

@main
struct ConsolidationVIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
