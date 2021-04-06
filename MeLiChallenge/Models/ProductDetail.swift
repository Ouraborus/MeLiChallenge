//
//  ProductDetail.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 3/04/21.
//

import Foundation

struct ProductDetail: Codable {
    let id: String
    let title: String
    let price: Double
    let currencyId: String
    var pictures: [Picture]
    let attributes: [Attribute]

    enum CodingKeys: String, CodingKey {
        case id, title, price, pictures, attributes
        case currencyId = "currency_id"
    }
}
