//
//  Attribute.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 4/04/21.
//

import Foundation

struct Attribute: Codable {
    let name: String
    let valueName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case valueName = "value_name"
    }
}
