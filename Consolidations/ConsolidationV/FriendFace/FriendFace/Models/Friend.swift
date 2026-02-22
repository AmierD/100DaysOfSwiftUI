//
//  Friend.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import Foundation

struct Friend: Codable, Hashable, Equatable {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
