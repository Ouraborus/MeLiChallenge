//
//  ServiceError.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 31/03/21.
//

import Foundation

enum ServiceError: Error {
    case unableToParse
    case badData
    case badUrl
}
