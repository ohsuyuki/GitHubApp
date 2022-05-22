//
//  UserListViewModel.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/21.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: Protocol
protocol UserListViewModelInputs {
    func viewDidLoad()
    func loadMore(users: [User])
}

protocol UserListViewModelOutputs {
    var users: Observable<[User]> { get }
}

typealias UserListViewModelType = UserListViewModelInputs & UserListViewModelOutputs

// MARK: ViewModel
class UserListViewModel: UserListViewModelType {
    let users: Observable<[User]>
    let viewDidLoadProperty = PublishSubject<Void>()
    let loadMoreProperty = PublishSubject<[User]>()

    init(client: GitHubApiClientType = GitHubApiClient()) {
        let initialLoadParamter = viewDidLoadProperty
            .map { 0 }

        let loadMoreParamter = loadMoreProperty
            .map { users -> Int in
                guard let lastUser = users.last else {
                    return 0
                }

                return lastUser.id
            }

        users = Observable.merge(initialLoadParamter, loadMoreParamter)
            .map { ["since": $0, "per_page": 20] }
            .flatMap { paramters in
                client.call(
                    endpoint: "https://api.github.com/users",
                    responseType: [User].self,
                    parameters: paramters
                )
            }
            .asObservable()
    }

    func viewDidLoad() {
        viewDidLoadProperty.onNext(())
    }

    func loadMore(users: [User]) {
        loadMoreProperty.onNext(users)
    }
}
