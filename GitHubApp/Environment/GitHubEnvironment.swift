//
//  GitHubEnvironment.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation

// MARK: Environment
protocol GitHubEnvironmentType {
    var authorization: String { get }
}

class GitHubEnvironment: GitHubEnvironmentType {
    let authorization: String = "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"
}
