//
//  RequestManagerRepository.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 31/03/21.
//

import Foundation

protocol RequestManagerRepository {
    typealias Response = (Result<Data, ServiceError>) -> Void

    static func request(type: RequestType, completion: @escaping Response)
    static func setSite(siteId: String?)
    static func getSelectedSite() -> String
}
