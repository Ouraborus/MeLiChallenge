//
//  RequestManagerRepository.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 31/03/21.
//

import Foundation

protocol RequestManagerRepository {
    typealias Response = (Result<Data, ServiceError>) -> Void

    static func getProducts(basedOn: String, completion: @escaping Response)
    static func getSites(completion: @escaping Response)
}
