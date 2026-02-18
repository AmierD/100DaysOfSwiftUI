//
//  User.swift
//  SwiftDataProject
//
//  Created by Amier Davis on 2/7/26.
//

import SwiftData
import Foundation

@Model
class User {
    // swift data with iCloud requires that all properties must be optional or have default values and all relationships must be optional
    var name: String = "Anonymous"
    var city: String = "Unknown"
    var joinDate: Date = Date.now
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()
    
    var unwrappedJobs: [Job] {
        jobs ?? []
    }
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}

