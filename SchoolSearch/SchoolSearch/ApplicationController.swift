//
//  ApplicationController.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

class ApplicationController {
    
    let networkManager = NetworkManager()
    let databaseManager = DatabaseManager()
    
    lazy var viewModel = {
        ViewModel(app: self)
    }()
    
}
