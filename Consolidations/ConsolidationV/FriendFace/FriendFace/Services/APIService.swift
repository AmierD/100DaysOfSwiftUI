//
//  APIService.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import Foundation

class APIService {
    static func fetchUsers() async -> [User] {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedUsers = try decoder.decode([User].self, from: data)
            
            print("uesrs fetched")
            
            return decodedUsers
        } catch {
            print("Error in API Service \(error.localizedDescription)")
            return []
        }
    }
}
