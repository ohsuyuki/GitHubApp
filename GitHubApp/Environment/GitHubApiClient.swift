//
//  GitHubApiClient.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation
import RxSwift
import Alamofire

enum GitHubApiClientError: Error {
    case unknownError
}

protocol GitHubApiClientType {
    func call<T: Decodable>(endpoint: String, responseType: T.Type) -> Single<T>
    func call<T: Decodable>(endpoint: String, responseType: T.Type, parameters: [String: Any]?) -> Single<T>
}

class GitHubApiClient: GitHubApiClientType {
    let environment: GitHubEnvironmentType

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    private var headers: HTTPHeaders {
        return [
            "Authorization": "Bearer \(self.environment.authorization)",
            "Accept": "application/json"
        ]
    }

    init(environment: GitHubEnvironmentType = GitHubEnvironment()) {
        self.environment = environment
    }

    func call<T: Decodable>(endpoint: String, responseType: T.Type) -> Single<T> {
        return call(endpoint: endpoint, responseType: responseType, parameters: nil)
    }

    func call<T: Decodable>(endpoint: String, responseType: T.Type, parameters: [String: Any]?) -> Single<T> {
        return Single.create { [weak self] observer in
            guard let self = self else {
                observer(.failure(GitHubApiClientError.unknownError))
                return Disposables.create()
            }

            AF.request(endpoint, parameters: parameters, headers: self.headers)
                .responseDecodable(
                    of: responseType,
                    decoder: self.decoder
                ) { response in
                    guard let value = response.value else {
                        observer(.failure(GitHubApiClientError.unknownError))
                        return
                    }

                    observer(.success(value))
                }

            return Disposables.create()
        }
    }
}
