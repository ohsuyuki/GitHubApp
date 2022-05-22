//
//  RepoListViewController.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import UIKit
import RxSwift
import SwiftUI

class RepoListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    private var dataSource: RepoListDataSource!
    private var viewModel: RepoListViewModelType!
    private let disposeBag = DisposeBag()

    func setUp(user: User) {
        dataSource = RepoListDataSource(user: user)
        viewModel = RepoListViewModel(user: user)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize view, viewModel
        configureTableView()
        bindViewModel()

        viewModel.viewDidLoad()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource

        dataSource.configure(tableView)
    }

    private func bindViewModel() {
        viewModel.repos
            .subscribe(
                onNext: { [weak self] repos in
                    guard let self = self else {
                        return
                    }

                    self.dataSource.update(self.tableView, repos: repos)
                }
            )
            .disposed(by: disposeBag)
    }
}

class RepoListDataSource: NSObject, UITableViewDataSource {
    enum Section: CaseIterable {
        case user
        case repo
    }

    struct Cell {
        static let userCell = "RepoListUserCell"
        static let repoCell = "RepoCell"
    }

    private let sections: [Section] = [
        .user,
        .repo
    ]

    private (set) var user: User!
    private (set) var repos: [Repo]!

    init(user: User) {
        self.user = user
        self.repos = []
    }

    func configure(_ tableView: UITableView) {
        tableView.register(UINib(nibName: Cell.userCell, bundle: nil), forCellReuseIdentifier: Cell.userCell)
        tableView.register(UINib(nibName: Cell.repoCell, bundle: nil), forCellReuseIdentifier: Cell.repoCell)

        updateUser(tableView)
    }

    private func updateUser(_ tableView: UITableView) {
        guard let index = sections.firstIndex(of: .user) else {
            return
        }

        tableView.beginUpdates()
        tableView.reloadSections(IndexSet([index]), with: .top)
        tableView.endUpdates()
    }

    func update(_ tableView: UITableView, repos: [Repo]) {
        guard let index = sections.firstIndex(of: .repo) else {
            return
        }

        self.repos.append(contentsOf: repos)

        tableView.beginUpdates()
        tableView.reloadSections(IndexSet([index]), with: .bottom)
        tableView.endUpdates()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard 0..<sections.count ~= section else {
            fatalError("section out of range (\(#function))")
        }

        switch sections[section] {
        case .user:
            return 1
        case .repo:
            return repos.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard 0..<sections.count ~= indexPath.section else {
            fatalError("indexPath.section out of range (\(#function))")
        }

        switch sections[indexPath.section] {
        case .user:
            return userCell(tableView, cellForRowAt: indexPath)
        case .repo:
            return repoCell(tableView, cellForRowAt: indexPath)
        }
    }

    func userCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row == 0 else {
            fatalError("indexPath.row out of range (\(#function))")
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.userCell, for: indexPath) as? RepoListUserCell else {
            fatalError("Unexpected error occurred")
        }

        cell.configure(user: user)
        return cell
    }

    func repoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard 0..<repos.count ~= indexPath.row else {
            fatalError("indexPath.row out of range (\(#function))")
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.repoCell, for: indexPath) as? RepoCell else {
            fatalError("Unexpected error occurred")
        }

        let repo = repos[indexPath.row]
        cell.configure(repo: repo)
        return cell
    }
}
