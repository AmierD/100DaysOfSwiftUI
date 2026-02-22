//
//  UserView.swift
//  FriendFace
//
//  Created by Amier Davis on 2/21/26.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        ZStack {
            statusIndicator
            
            nameAndCompany
            
            tagList
        }
        .frame(width: 300, height: 150)
    }
    
    var statusIndicator: some View {
        VStack {
            Circle()
                .frame(width: 20, height: 20)
                    .foregroundStyle(user.isActive ? .green : .red)
                    .shadow(color: user.isActive ? .green.opacity(0.8) : .red.opacity(0.8), radius: 3)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .trailing)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    var tagList: some View {
        VStack {
            Spacer()
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(5)
                            .background(.tint)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    }
                }
                .padding()
            }
        }
        .scrollIndicators(.hidden)
    }
    
    var nameAndCompany: some View {
        HStack {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(user.company)
                }
                Spacer()
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)

    }
}
