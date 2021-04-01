//
//  RequestManagerProtocol.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 31/03/21.
//

import Foundation
import CoreData

protocol RequestManagerProtocol {
    typealias ProductResponse = (Result<Data, ServiceError>) -> Void

    static func getProducts(completion: @escaping ProductResponse)
}
