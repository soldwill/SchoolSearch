//
//  SchoolSearchApp.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import SwiftUI

@main
struct SchoolSearchApp: App {
    let app = ApplicationController()
    var body: some Scene {
        WindowGroup {
            SchoolSearchView(viewModel: app.viewModel)
        }
    }
}
