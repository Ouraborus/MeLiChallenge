//
//  RequestManagerMock.swift
//  MeLiChallengeTests
//
//  Created by Esteban Cardona Alvarez on 6/04/21.
//

import Foundation
@testable import MeLiChallenge

class RequestManagerMock: RequestManagerRepository {

    static var requestWasCalled = false
    static var lastRequestMade: RequestType?


    static func request(type: RequestType, completion: @escaping Response) {
        guard let data = loadJson(filename: "SitesMock") else {
            completion(.failure(.badData))
            return
        }

        completion(.success(data))

        lastRequestMade = type
        requestWasCalled = true
    }

    static func setSite(siteId: String?) {

    }

    static func getSelectedSite() -> String {
        return ""
    }

    private static func loadJson(filename fileName: String) -> Data? {
        guard let url = Bundle(for: self).path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let data = try? Data(contentsOf: URL(fileURLWithPath: url))
        return data
    }
}
