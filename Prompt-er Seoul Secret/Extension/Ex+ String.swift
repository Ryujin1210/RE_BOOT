//
//  Ex+ String.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/23.
//

import Foundation

extension String {
    func spaceCount() -> Int {
        return self.filter { ($0) == " " }.count
    }
}
