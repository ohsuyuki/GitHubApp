//
//  RepoCell.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import UIKit

class RepoCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(repo: Repo) {
        nameLabel.text = repo.name
    }

}
