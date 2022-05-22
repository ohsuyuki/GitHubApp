//
//  RepoListUserViewModel.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: Protocol
protocol RepoListUserViewModelInputs {
    func configure()
}

protocol RepoListUserViewModelOutputs {
    var userName: Observable<String> { get }
    var followers: Observable<String> { get }
    var following: Observable<String> { get }
}

typealias RepoListUserViewModelType = RepoListUserViewModelInputs & RepoListUserViewModelOutputs

// MARK: ViewModel
class RepoListUserViewModel: RepoListUserViewModelType {
    let configureProperty = PublishSubject<Void>()
    let userName: Observable<String>
    let followers: Observable<String>
    let following: Observable<String>

    init(
        user: User,
        client: GitHubApiClientType = GitHubApiClient()
    ) {
        userName = Observable.just(user)
            .map { $0.login }

        let userDetail = configureProperty
            .flatMap { client.call(endpoint: user.url, responseType: UserDetail.self) }
            .share(replay: 1)

        followers = userDetail
            .map { String($0.followers) }

        following = userDetail
            .map { String($0.following) }
    }

    func configure() {
        configureProperty.onNext(())
    }
}
