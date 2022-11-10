//
//  SortHelper.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

class SortHelper<SearchItem: Hashable> {
    
    func processSearchResults(withWords words: [String],
                              andItemsWithSearchTerms itemsWithSearchTerms: [ItemWithSearchTerms<SearchItem>],
                              andPreferredOrdering preferredOrdering: [SearchItem]) async -> [SearchItem] {
        
        var preferredOrderDict = [SearchItem: Int]()
        for (index, item) in preferredOrdering.enumerated() {
            preferredOrderDict[item] = index
        }
        
        var sortHelperNodes = [SortHelperNode<SearchItem>]()
        for itemWithSearchTerms in itemsWithSearchTerms {
            let sorHelpertNode = SortHelperNode(words: words, itemWithSearchTerms: itemWithSearchTerms)
            sortHelperNodes.append(sorHelpertNode)
        }
        
        sortHelperNodes.sort { lhs, rhs in
            if lhs.prefixCount == rhs.prefixCount {
                if lhs.isInOrderExact == rhs.isInOrderExact {
                    if lhs.isInOrderStaggered == rhs.isInOrderStaggered {
                        if lhs.doesStartWithSameFirstWord == rhs.doesStartWithSameFirstWord {
                            let lhsIndex = preferredOrderDict[lhs.itemWithSearchTerms.item] ?? 0
                            let rhsIndex = preferredOrderDict[rhs.itemWithSearchTerms.item] ?? 0
                            return lhsIndex < rhsIndex
                        } else {
                            return lhs.doesStartWithSameFirstWord
                        }
                    } else {
                        return lhs.isInOrderStaggered
                    }
                } else {
                    return lhs.isInOrderExact
                }
            } else {
                return lhs.prefixCount > rhs.prefixCount
            }
        }
        
        let result = sortHelperNodes.map {
            $0.itemWithSearchTerms.item
        }
        return result
    }
}
