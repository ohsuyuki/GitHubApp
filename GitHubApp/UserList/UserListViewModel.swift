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

    init(usersRepository: GitHubUsersRepositoryType = GitHubUsersRepository()) {
        users = viewDidLoadProperty
            .flatMap {
                return usersRepository.listUsers()
            }
            .asObservable()
    }

    func viewDidLoad() {
        viewDidLoadProperty.onNext(())
    }
}
