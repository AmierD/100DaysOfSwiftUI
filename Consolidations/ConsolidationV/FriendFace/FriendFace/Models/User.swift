//
//  User.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    
    var friends: [Friend]
}

extension User {
    static let sample = User(
        id: UUID(),
        isActive: false,
        name: "Anon",
        age: 19,
        company: "Twitter",
        email: "example@email.com",
        address: "123 Address Dr",
        about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
        registered: .now,
        tags: [
            "cillum",
            "consequat",
            "deserunt",
            "nostrud",
            "eiusmod",
            "minim",
            "tempor"
        ],
        friends: [
            Friend(id: UUID(), name: "Random"),
            Friend(id: UUID(), name: "Random2"),
            Friend(id: UUID(), name: "Random3"),
        ]
    )
}
