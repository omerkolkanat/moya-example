//
//  SearchResponse.swift
//  MoyaExample
//
//  Created by Ömer Kolkanat on 16.05.2020.
//  Copyright © 2020 Omer Kolkanat. All rights reserved.
//

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let page, totalResults, totalPages: Int?
    let results: [MovieResult]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
