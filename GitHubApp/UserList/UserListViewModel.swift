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
}

protocol UserListViewModelOutputs {
    var users: Observable<[User]> { get }
}

typealias UserListViewModelType = UserListViewModelInputs & UserListViewModelOutputs

// MARK: ViewModel
class UserListViewModel: UserListViewModelType {
    let users: Observable<[User]>
    let viewDidLoadProperty = PublishSubject<Void>()

    init(client: GitHubApiClientType = GitHubApiClient()) {
        users = viewDidLoadProperty
            .flatMap {
                return client.call(endpoint: "https://api.github.com/users", responseType: [User].self)
            }
            .asObservable()
    }

    func viewDidLoad() {
        viewDidLoadProperty.onNext(())
    }
}
