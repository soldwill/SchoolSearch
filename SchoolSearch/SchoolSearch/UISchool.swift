//
//  UISchool.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

struct UISchool {
    let dbn: String
    let school_name: String
    let school_name_char_array: [Character]
    let school_name_char_array_lowercased: [Character]
    
    init(dbn: String,
         school_name: String) {
        self.dbn = dbn
        self.school_name = school_name
        self.school_name_char_array = Array(school_name)
        self.school_name_char_array_lowercased = Array(school_name.lowercased())
    }
    
    init(nwSchool: NWSchool) {
        self.init(dbn: nwSchool.dbn,
                  school_name: nwSchool.school_name)
    }
    
    init(dbSchool: DBSchool) {
        self.init(dbn: dbSchool.dbn ?? "",
                  school_name: dbSchool.school_name ?? "")
    }
    
}

extension UISchool: Identifiable {
    var id: String { dbn }
}
