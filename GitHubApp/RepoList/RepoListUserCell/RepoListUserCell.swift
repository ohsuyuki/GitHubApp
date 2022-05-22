//
//  RepoListUserCell.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class RepoListUserCell: RxReusableTableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    private var viewModel: RepoListUserViewModelType!

    override func layoutSubviews() {
        super.layoutSubviews()

        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2.0

        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }

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
        viewModel.name
            .asDriver(onErrorJustReturn: "-")
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.fullName
            .asDriver(onErrorJustReturn: "()")
            .drive(fullNameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.avatarUrl
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] avatarUrl in
                guard let self = self, let avatarUrl = avatarUrl else {
                    return
                }

                self.avatarImage.af.setImage(
                    withURL: avatarUrl,
                    placeholderImage: self.avatarImage.image
                )
            })
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
