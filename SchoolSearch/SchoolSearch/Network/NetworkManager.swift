//
//  NetworkManager.swift
//  SchoolSearch
//
//  Created by Soldier Williams on 11/10/22.
//

import Foundation

class NetworkManager {
    func fetchSchools() async throws -> [NWSchool] {
        let urlString = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let schools = try JSONDecoder().decode([NWSchool].self, from: data)
        return schools
    }
}
