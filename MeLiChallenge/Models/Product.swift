//
//  Product.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 31/03/21.
//

import Foundation

struct Product: Codable {
    let id: String
    let title: String
    let price: Double
    let permalink: String
    let thumbnail: String

    // let attributes: [Attribute]? (Necesarios en ProductDetail) https://api.mercadolibre.com/items/MCO613589680
}