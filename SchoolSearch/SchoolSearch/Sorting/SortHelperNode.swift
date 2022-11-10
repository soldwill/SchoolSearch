//
//  SortHelperNode.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

class SortHelperNode<SearchItem> {
    
    let words: [String]
    let itemWithSearchTerms: ItemWithSearchTerms<SearchItem>
    
    private(set) var prefixCount = 0
    private(set) var isInOrderExact = false
    private(set) var isInOrderStaggered = false
    private(set) var doesStartWithSameFirstWord = false
    
    init(words: [String], itemWithSearchTerms: ItemWithSearchTerms<SearchItem>) {
        self.words = words
        self.itemWithSearchTerms = itemWithSearchTerms
        computePrefixCount()
        computeIsInOrderExact()
        computeIsInOrderStaggered()
        computeDoesStartWithSameFirstWord()
    }
    
    private func computePrefixCount() {
        prefixCount = 0
        for word in words {
            var isPrefix = false
            for searchTerm in itemWithSearchTerms.searchTerms {
                guard let range = searchTerm.range(of: word) else { continue }
                if range.lowerBound == searchTerm.startIndex {
                    isPrefix = true
                }
            }
            if isPrefix {
                prefixCount += 1
            }
        }
    }
    
    private func computeIsInOrderExact() {
        isInOrderExact = false
        for wordIndex in 0..<min(words.count, itemWithSearchTerms.searchTerms.count) {
            let word = words[wordIndex]
            let searchTerm = itemWithSearchTerms.searchTerms[wordIndex]
            if searchTerm.range(of: word) == nil {
                return
            }
        }
        isInOrderExact = true
    }
    
    private func computeIsInOrderStaggered() {
        isInOrderStaggered = false
        var wordIndex = 0
        var termIndex = 0
        while wordIndex < words.count && termIndex < itemWithSearchTerms.searchTerms.count {
            let word = words[wordIndex]
            let searchTerm = itemWithSearchTerms.searchTerms[termIndex]
            if searchTerm.range(of: word) != nil {
                wordIndex += 1
                termIndex += 1
                if wordIndex == words.count {
                    isInOrderStaggered = true
                    return
                }
            } else {
                termIndex += 1
            }
        }
    }
    
    private func computeDoesStartWithSameFirstWord() {
        doesStartWithSameFirstWord = false
        guard words.count > 0 else { return }
        guard itemWithSearchTerms.searchTerms.count > 0 else { return }
        
        let word = words[0]
        let searchTerm = itemWithSearchTerms.searchTerms[0]
        
        guard let range = searchTerm.range(of: word) else { return }
        
        if range.lowerBound == searchTerm.startIndex {
            doesStartWithSameFirstWord = true
        }
    }
    
}
