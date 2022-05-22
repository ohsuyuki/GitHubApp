//
//  RxReusableTableViewCell.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation
import UIKit
import RxSwift

class RxReusableTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
