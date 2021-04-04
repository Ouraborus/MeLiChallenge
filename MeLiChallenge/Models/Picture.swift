//
//  Picture.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 3/04/21.
//

import Foundation

struct Picture: Codable {
    let id: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case url = "secure_url"
    }
}
