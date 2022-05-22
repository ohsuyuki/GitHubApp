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
    var name: Observable<String> { get }
    var fullName: Observable<String> { get }
    var avatarUrl: Observable<URL?> { get }
    var followers: Observable<String> { get }
    var following: Observable<String> { get }
}

typealias RepoListUserViewModelType = RepoListUserViewModelInputs & RepoListUserViewModelOutputs

// MARK: ViewModel
class RepoListUserViewModel: RepoListUserViewModelType {
    let configureProperty = PublishSubject<Void>()
    let name: Observable<String>
    let fullName: Observable<String>
    var avatarUrl: Observable<URL?>
    let followers: Observable<String>
    let following: Observable<String>

    init(
        user: User,
        client: GitHubApiClientType = GitHubApiClient()
    ) {
        let observableUser = Observable.just(user)
            .share(replay: 1)

        name = observableUser
            .map { $0.login }

        avatarUrl = observableUser
            .map { URL(string: $0.avatarUrl) }

        let userDetail = configureProperty
            .flatMap { client.call(endpoint: user.url, responseType: UserDetail.self) }
            .share(replay: 1)

        fullName = userDetail
            .map { "(\($0.name))" }

        followers = userDetail
            .map { String($0.followers) }

        following = userDetail
            .map { String($0.following) }
    }

    func configure() {
        configureProperty.onNext(())
    }
}
