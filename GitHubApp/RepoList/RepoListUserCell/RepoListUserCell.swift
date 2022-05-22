//
//  RepoListUserCell.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import UIKit
import RxSwift
import RxCocoa

class RepoListUserCell: RxReusableTableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    private var viewModel: RepoListUserViewModelType!

    func configure(user: User, with viewModelInjection: RepoListUserViewModelType? = nil) {
        configureViewModel(
            viewModelInjection,
            user: user
        )

        bindViewModel()

        viewModel.configure()
    }

    private func configureViewModel(_ viewModel: RepoListUserViewModelType?, user: User) {
        if let viewModel = viewModel {
            self.viewModel = viewModel
        } else {
            self.viewModel = RepoListUserViewModel(user: user)
        }
    }
    
    private func bindViewModel() {
        viewModel.userName
            .asDriver(onErrorJustReturn: "-")
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.followers
            .asDriver(onErrorJustReturn: "-")
            .drive(followersLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.following
            .asDriver(onErrorJustReturn: "-")
            .drive(followingLabel.rx.text)
            .disposed(by: disposeBag)
    }
}