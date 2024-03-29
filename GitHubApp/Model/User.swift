//
//  User.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let url: String
    let reposUrl: String
    let avatarUrl: String
}
