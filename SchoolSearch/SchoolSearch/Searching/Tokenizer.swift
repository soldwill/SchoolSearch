//
//  Tokenizer.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

class Tokenizer {
    static func tokenize(_ string: String?) -> [String] {
        guard let string = string else {
            return [String]()
        }
        let tokenSequences = string.split(separator: " ")
        let tokens = tokenSequences.compactMap {
            let token = String($0).trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            return (token.count > 0) ? token : nil
        }
        return tokens
    }
}
