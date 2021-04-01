//
//  SearchResult.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 1/04/21.
//

import Foundation

struct SearchResult: Codable {
    let siteId: String
    let query: String
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case query
        case siteId = "site_id"
        case products = "results"
    }
}
