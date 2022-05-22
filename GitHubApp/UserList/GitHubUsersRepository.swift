//
//  GitHubUsersRepository.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/21.
//

import Foundation
import RxSwift
import Alamofire

enum GitHubUsersRepositoryError: Error {
    case unknownError
}

protocol GitHubUsersRepositoryType {
    func listUsers() -> Single<[User]>
}

class GitHubUsersRepository: GitHubUsersRepositoryType {
    static var environment: GitHubUsersEnvironmentType = GitHubUsersEnvironment()

    func listUsers() -> Single<[User]> {
        return Single.create { observer in
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(GitHubUsersRepository.environment.authorization)",
                "Accept": "application/json"
            ]

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            AF.request("https://api.github.com/users", headers: headers)
                .responseDecodable(
                    of: [User].self,
                    decoder: decoder
                ) { response in
                    guard let value = response.value else {
                        observer(.failure(GitHubUsersRepositoryError.unknownError))
                        return
                    }

                    observer(.success(value))
                }

            return Disposables.create()
        }
    }
}

// MARK: Environment
protocol GitHubUsersEnvironmentType {
    var authorization: String { get }
}

class GitHubUsersEnvironment: GitHubUsersEnvironmentType {
    let authorization: String = "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"
}
