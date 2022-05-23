//
//  GitHubEnvironment.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation

// MARK: Environment
protocol GitHubEnvironmentType {
    var accessToken: String? { get }
}

class GitHubEnvironment: GitHubEnvironmentType {
    var accessToken: String? {
        return ProcessInfo.processInfo.environment["ACCESS_TOKEN"]
    }
}
