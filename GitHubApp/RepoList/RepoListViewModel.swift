//
//  RepoListViewModel.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: Protocol
protocol RepoListViewModelInputs {
    func viewDidLoad()
}

protocol RepoListViewModelOutputs {
    var repos: Observable<[Repo]> { get }
}

typealias RepoListViewModelType = RepoListViewModelInputs & RepoListViewModelOutputs

// MARK: ViewModel
class RepoListViewModel: RepoListViewModelType {
    let repos: Observable<[Repo]>
    let viewDidLoadProperty = PublishSubject<Void>()

    init(
        user: User,
        client: GitHubApiClientType = GitHubApiClient()
    ) {
        repos = viewDidLoadProperty
            .flatMap { client.call(endpoint: user.reposUrl, responseType: [Repo].self) }
            .map { $0.filter { !$0.fork } }
    }

    func viewDidLoad() {
        viewDidLoadProperty.onNext(())
    }
}

