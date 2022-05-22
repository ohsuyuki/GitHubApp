//
//  RepoListUserCell.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import UIKit

class RepoListUserCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    func configure(user: User) {
        nameLabel.text = user.login
    }
}
