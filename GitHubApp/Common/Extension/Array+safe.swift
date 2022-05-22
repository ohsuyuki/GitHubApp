//
//  Array+safe.swift
//  GitHubApp
//
//  Created by yuuki oosu on 2022/05/22.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        guard 0..<self.count ~= index else {
            return nil
        }

        return self[index]
    }
}
