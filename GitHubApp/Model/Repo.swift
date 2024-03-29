//
//  Repo.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation

struct Repo: Decodable {
    let name: String
    let htmlUrl: String
    let description: String?
    let stargazersCount: Int
    let language: String?
    let fork: Bool
}
