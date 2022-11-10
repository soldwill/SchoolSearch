//
//  ItemWithSearchTerms.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

protocol ItemWithSearchTermsConvertible {
    associatedtype SearchItem
    func toItemWithSearchTerms() -> ItemWithSearchTerms<SearchItem>
}

struct ItemWithSearchTerms<SearchItem> {
    let item: SearchItem
    let searchTerms: [String]
    init(item: SearchItem, searchTerms: [String]) {
        self.item = item
        self.searchTerms = searchTerms
    }
}
