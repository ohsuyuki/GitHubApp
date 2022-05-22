//
//  UserDetail.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation

struct UserDetail: Codable {
    let login: String
    let name: String
    let followers: Int
    let following: Int
}
