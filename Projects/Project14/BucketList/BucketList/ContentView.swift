//
//  ContentView.swift
//  BucketList
//
//  Created by Amier Davis on 3/1/26.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct ContentView: View {
    @State private var loadingState: LoadingState = .loading
    
    let users = [
        User(firstName: "A", lastName: "B"),
        User(firstName: "E", lastName: "F"),
        User(firstName: "C", lastName: "D"),
    ].sorted()
    
    var body: some View {
        switch loadingState {
        case .loading:
            loadingView
        case .success:
            successView
        case .failed:
            failedView
        }
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
        Button("read and Write") {
            let data = Data("Test Message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")
            
            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
        }
        Button("Cycle", action: cycleLoadingState)
    }
    var loadingView: some View {
        Text("Loading...")
    }
    var successView: some View {
        Text("Success!")
    }
    var failedView: some View {
        Text("Failed.")
    }
    func cycleLoadingState() {
        switch loadingState {
        case .loading:
            loadingState = .success
        case .success:
            loadingState = .failed
        case .failed:
            loadingState = .loading
        }
    }
}

struct User: Identifiable {
    let id = UUID()
    var firstName: String
    var lastName: String
}

extension User: Comparable {
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

#Preview {
    ContentView()
}
