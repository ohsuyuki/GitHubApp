//
//  UserListViewController.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/21.
//

import UIKit
import RxSwift

class UsersDataSource: NSObject, UITableViewDataSource {
    struct Cell {
        static let userCell = "UserCell"
    }

    private (set) var users: [User] = []

    func configure(_ tableView: UITableView) {
        tableView.register(UINib(nibName: Cell.userCell, bundle: nil), forCellReuseIdentifier: Cell.userCell)
    }

    func update(_ tableView: UITableView, users: [User]) {
        self.users = users

        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard 0..<users.count ~= indexPath.row else {
            fatalError("IndexPath.row out of range (\(#function))")
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.userCell, for: indexPath) as? UserCell else {
            fatalError("Unexpected error occurred")
        }

        let user = users[indexPath.row]
        cell.configure(user: user)
        
        return cell
    }
}

class UserListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    private let dataSource = UsersDataSource()
    private let viewModel: UserListViewModelType = UserListViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize view, viewModel
        configureTableView()
        bindViewModel()

        viewModel.viewDidLoad()
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource

        dataSource.configure(tableView)
    }

    func bindViewModel() {
        viewModel.users
            .subscribe(
                onNext: { [weak self] users in
                    guard let self = self else {
                        return
                    }

                    self.dataSource.update(self.tableView, users: users)
                }
            )
            .disposed(by: disposeBag)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard 0..<dataSource.users.count ~= indexPath.row else {
            fatalError("IndexPath.row out of range (\(#function))")
        }

        let user = dataSource.users[indexPath.row]

        toRepositoryListView(user: user)
    }

    func toRepositoryListView(user: User) {
        let storyboard = UIStoryboard(name: "RepositoryList", bundle: nil)
//        guard let viewController = storyboard.instantiateInitialViewController() as? ConfigurableView<ChatViewConfig> else {
//            return
//        }

//        let config = ChatViewConfig(opponentName: user.name)
//        viewController.configure(config)
        guard let viewController = storyboard.instantiateInitialViewController() else {
            return
        }

        navigationController?.pushViewController(viewController, animated: true)
    }
}
