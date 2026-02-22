//
//  UsersViewModel.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import Foundation

@Observable
class UsersViewModel {
    var users: [User] = []
    
    func fetchUsers() async {
        users = await APIService.fetchUsers()
    }
}
