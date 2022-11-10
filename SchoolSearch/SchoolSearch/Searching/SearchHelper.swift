//
//  SearchHelper.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

class SearchHelper<SearchItem> {
    
    private func eliminateSharedMatches(withWords words: [String],
                                        andItems items: [ItemWithSearchTerms<SearchItem>]) async -> [ItemWithSearchTerms<SearchItem>] {
        
        func helper(searchTerms: [String],
                    usedSearchTerms: inout [Bool],
                    words: [String],
                    wordIndex: Int,
                    matchCount: Int) -> Bool {
            
            if matchCount == words.count { return true }
            if wordIndex == words.count { return false }
            let word = words[wordIndex]
            
            for termIndex in searchTerms.indices {
                if usedSearchTerms[termIndex] == false {
                    let searchTerm = searchTerms[termIndex]
                    if searchTerm.range(of: word) != nil {
                        usedSearchTerms[termIndex] = true
                        if helper(searchTerms: searchTerms,
                                  usedSearchTerms: &usedSearchTerms,
                                  words: words,
                                  wordIndex: wordIndex + 1,
                                  matchCount: matchCount + 1) {
                            return true
                        }
                        usedSearchTerms[termIndex] = false
                    }
                }
            }
            return false
        }
        
        var result = [ItemWithSearchTerms<SearchItem>]()
        for item in items {
            var usedSearchTerms = [Bool](repeating: false, count: item.searchTerms.count)
            if helper(searchTerms: item.searchTerms,
                      usedSearchTerms: &usedSearchTerms,
                      words: words,
                      wordIndex: 0,
                      matchCount: 0) {
                result.append(item)
            }
        }
        return result
    }
    
    func processRawMatches(withWords words: [String],
                           andItems items: [ItemWithSearchTerms<SearchItem>]) async -> [ItemWithSearchTerms<SearchItem>] {
        if words.count <= 0 {
            return items
        }
        return await eliminateSharedMatches(withWords: words, andItems: items)
    }
}
