//
//  Site.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 2/04/21.
//

import Foundation

struct Site: Codable {
    let currencyId: String
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case currencyId = "default_currency_id"
        case id, name
    }
}
