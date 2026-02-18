//
//  Job.swift
//  SwiftDataProject
//
//  Created by Amier Davis on 2/18/26.
//

import SwiftData

@Model
class Job {
    // swift data with iCloud requires that all properties must be optional or have default values and all relationships must be optional
    var name: String = "None"
    var priority: Int = 1
    var owner: User?
    
    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
