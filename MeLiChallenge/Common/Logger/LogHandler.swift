//
//  LogHandler.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 8/04/21.
//

import Foundation
import os

struct LogHandler: LoggerProtocol {
    private let requestLogger = Logger()
    static var shared = LogHandler()

    func logError(message: StringLiteralType) {
        requestLogger.info("\(message)")
    }
}
