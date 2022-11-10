//
//  DatabaseManager.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation


import Foundation
import CoreData

class DatabaseManager {
    
    let container: NSPersistentContainer
    private let searchHelper = SearchHelper<DBSchool>()
    private let sortHelper = SortHelper<DBSchool>()
    required init() {
        container = NSPersistentContainer(name: "Database")
    }
    
    func loadPersistentStores() async {
        await withCheckedContinuation { continuation in
            container.loadPersistentStores { description, error in
                continuation.resume()
            }
        }
    }
    
    func fetchSchools() async throws -> [DBSchool] {
        let context = container.viewContext
        var result = [DBSchool]()
        try await context.perform {
            let fetchRequest = DBSchool.fetchRequest()
            result = try context.fetch(fetchRequest)
        }
        return result
    }
    
    func searchSchools(withSearchWords searchWords: [String]) async throws -> [DBSchool] {
        guard searchWords.count > 0 else {
            let result = try await fetchSchools()
            return result
        }
        
        let context = container.viewContext
        
        let coreDataResult = try await buildSearchResultsFor(words: searchWords, inContext: context)
        
        var items = coreDataResult.map {
            $0.toItemWithSearchTerms()
        }
        
        items = await searchHelper.processRawMatches(withWords: searchWords,
                                                     andItems: items)
        
        let preferredOrdering = try await fetchSchools()
        let result = await sortHelper.processSearchResults(withWords: searchWords,
                                                           andItemsWithSearchTerms: items,
                                                           andPreferredOrdering: preferredOrdering)
        return result
    }
    
    func updateData(nwSchools: [NWSchool]) async throws {
        let context = container.viewContext
        try await context.perform {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBSchool")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(batchDeleteRequest)
            
            for nwSchool in nwSchools {
                let dbSchool = DBSchool(context: context)
                dbSchool.dbn = nwSchool.dbn
                dbSchool.school_name = nwSchool.school_name
                
                let searchTerms = Tokenizer.tokenize(nwSchool.school_name)
                
                if searchTerms.count >  0 { dbSchool.search_term_00 = searchTerms[ 0] }
                if searchTerms.count >  1 { dbSchool.search_term_01 = searchTerms[ 1] }
                if searchTerms.count >  2 { dbSchool.search_term_02 = searchTerms[ 2] }
                if searchTerms.count >  3 { dbSchool.search_term_03 = searchTerms[ 3] }
                if searchTerms.count >  4 { dbSchool.search_term_04 = searchTerms[ 4] }
                if searchTerms.count >  5 { dbSchool.search_term_05 = searchTerms[ 5] }
                if searchTerms.count >  6 { dbSchool.search_term_06 = searchTerms[ 6] }
                if searchTerms.count >  7 { dbSchool.search_term_07 = searchTerms[ 7] }
                if searchTerms.count >  8 { dbSchool.search_term_08 = searchTerms[ 8] }
                if searchTerms.count >  9 { dbSchool.search_term_09 = searchTerms[ 9] }
                if searchTerms.count > 10 { dbSchool.search_term_10 = searchTerms[10] }
                if searchTerms.count > 11 { dbSchool.search_term_11 = searchTerms[11] }
                if searchTerms.count > 12 { dbSchool.search_term_12 = searchTerms[12] }
                if searchTerms.count > 13 { dbSchool.search_term_13 = searchTerms[13] }
                if searchTerms.count > 14 { dbSchool.search_term_14 = searchTerms[14] }
                if searchTerms.count > 15 { dbSchool.search_term_15 = searchTerms[15] }
                
            }
            try context.save()
        }
    }
    
    func buildSearchResultsFor(words: [String], inContext context: NSManagedObjectContext) async throws -> [DBSchool] {
        
        var andPredicateList = [NSPredicate]()
        for word in words {
            let predicate_00 = NSPredicate(format: "search_term_00 CONTAINS %@", word)
            let predicate_01 = NSPredicate(format: "search_term_01 CONTAINS %@", word)
            let predicate_02 = NSPredicate(format: "search_term_02 CONTAINS %@", word)
            let predicate_03 = NSPredicate(format: "search_term_03 CONTAINS %@", word)
            let predicate_04 = NSPredicate(format: "search_term_04 CONTAINS %@", word)
            let predicate_05 = NSPredicate(format: "search_term_05 CONTAINS %@", word)
            let predicate_06 = NSPredicate(format: "search_term_06 CONTAINS %@", word)
            let predicate_07 = NSPredicate(format: "search_term_07 CONTAINS %@", word)
            let predicate_08 = NSPredicate(format: "search_term_08 CONTAINS %@", word)
            let predicate_09 = NSPredicate(format: "search_term_09 CONTAINS %@", word)
            let predicate_10 = NSPredicate(format: "search_term_10 CONTAINS %@", word)
            let predicate_11 = NSPredicate(format: "search_term_11 CONTAINS %@", word)
            let predicate_12 = NSPredicate(format: "search_term_12 CONTAINS %@", word)
            let predicate_13 = NSPredicate(format: "search_term_13 CONTAINS %@", word)
            let predicate_14 = NSPredicate(format: "search_term_14 CONTAINS %@", word)
            let predicate_15 = NSPredicate(format: "search_term_15 CONTAINS %@", word)
            
            let orPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [
                predicate_00, predicate_01, predicate_02, predicate_03,
                predicate_04, predicate_05, predicate_06, predicate_07,
                predicate_08, predicate_09, predicate_10, predicate_11,
                predicate_12, predicate_13, predicate_14, predicate_15])
            andPredicateList.append(orPredicate)
        }
        
        let finalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: andPredicateList)
        let fetchRequest = DBSchool.fetchRequest()
        fetchRequest.predicate = finalPredicate
        
        var result = [DBSchool]()
        try await context.perform {
            result = try context.fetch(fetchRequest)
        }
        return result
    }
    
}
