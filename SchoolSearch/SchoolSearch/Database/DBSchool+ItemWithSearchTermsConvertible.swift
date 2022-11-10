//
//  DBSchool+ItemWithSearchTermsConvertible.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

extension DBSchool: ItemWithSearchTermsConvertible {
    func toItemWithSearchTerms() -> ItemWithSearchTerms<DBSchool> {
        var searchTerms = [String]()
        if let search_term_00 = self.search_term_00 { searchTerms.append(search_term_00.lowercased()) }
        if let search_term_01 = self.search_term_01 { searchTerms.append(search_term_01.lowercased()) }
        if let search_term_02 = self.search_term_02 { searchTerms.append(search_term_02.lowercased()) }
        if let search_term_03 = self.search_term_03 { searchTerms.append(search_term_03.lowercased()) }
        if let search_term_04 = self.search_term_04 { searchTerms.append(search_term_04.lowercased()) }
        if let search_term_05 = self.search_term_05 { searchTerms.append(search_term_05.lowercased()) }
        if let search_term_06 = self.search_term_06 { searchTerms.append(search_term_06.lowercased()) }
        if let search_term_07 = self.search_term_07 { searchTerms.append(search_term_07.lowercased()) }
        if let search_term_08 = self.search_term_08 { searchTerms.append(search_term_08.lowercased()) }
        if let search_term_09 = self.search_term_09 { searchTerms.append(search_term_09.lowercased()) }
        if let search_term_10 = self.search_term_10 { searchTerms.append(search_term_10.lowercased()) }
        if let search_term_11 = self.search_term_11 { searchTerms.append(search_term_11.lowercased()) }
        if let search_term_12 = self.search_term_12 { searchTerms.append(search_term_12.lowercased()) }
        if let search_term_13 = self.search_term_13 { searchTerms.append(search_term_13.lowercased()) }
        if let search_term_14 = self.search_term_14 { searchTerms.append(search_term_14.lowercased()) }
        if let search_term_15 = self.search_term_15 { searchTerms.append(search_term_15.lowercased()) }
        return ItemWithSearchTerms<DBSchool>(item: self, searchTerms: searchTerms)
    }
}

