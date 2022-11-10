//
//  ViewModel.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var schools = [UISchool]()
    private let boldifier = MatchingTextBoldifier()
    
    let app: ApplicationController
    init(app: ApplicationController) {
        self.app = app
        initializationSequence()
    }
    
    func initializationSequence() {
        Task {
            
            await app.databaseManager.loadPersistentStores()
            
            var nwSchools = [NWSchool]()
            do {
                nwSchools = try await app.networkManager.fetchSchools()
            } catch let error {
                print("ERROR: networkManager fetchSchools: \(error.localizedDescription)")
            }
            
            if nwSchools.count > 0 {
                do {
                    try await app.databaseManager.updateData(nwSchools: nwSchools)
                } catch let error {
                    print("ERROR: databaseManager updateData: \(error.localizedDescription)")
                }
            }
            
            await updateSearchTextAsync(searchText)
        }
    }
    
    private(set) var searchText = ""
    private(set) var searchWords = [String]()
    func updateSearchTextIntent(_ searchText: String) {
        Task {
            await updateSearchTextAsync(searchText)
        }
    }
    
    private func updateSearchTextAsync(_ searchText: String) async {
        self.searchText = searchText
        self.searchWords = Tokenizer.tokenize(searchText)
        
        var dbSchools = [DBSchool]()
        do {
            dbSchools = try await app.databaseManager.searchSchools(withSearchWords: searchWords)
        } catch let error {
            print("ERROR: databaseManager searchSchools: \(error.localizedDescription)")
        }
        
        let uiSchools = dbSchools.map {
            UISchool(dbSchool: $0)
        }
        
        await MainActor.run {
            self.boldifier.resetWith(words: self.searchWords)
            self.schools = uiSchools
        }
    }
    
    func name(for school: UISchool) -> AttributedString {
        return boldifier.attributedString(for: school)
    }
    
}
