//
//  Student.swift
//  Bookworm
//
//  Created by Amier Davis on 2/2/26.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
