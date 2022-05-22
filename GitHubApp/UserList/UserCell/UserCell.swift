//
//  UserCell.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import UIKit
import AlamofireImage

class UserCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2.0
    }

    func configure(user: User) {
        nameLabel.text = user.login

        if let avatarUrl = URL(string: user.avatarUrl) {
            avatarImage.af.setImage(
                withURL: avatarUrl,
                placeholderImage: avatarImage.image
            )
        }
    }
}
