//
//  RepoCell.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import UIKit

class RepoCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(repo: Repo) {
        nameLabel.text = repo.name
        languageLabel.text = repo.language
        starLabel.text = String(repo.stargazersCount)
        descriptionLabel.text = repo.description
    }
}
