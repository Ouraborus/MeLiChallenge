//
//  RequestManagerMock.swift
//  MeLiChallengeTests
//
//  Created by Esteban Cardona Alvarez on 6/04/21.
//

import Foundation
@testable import MeLiChallenge

enum ModelMock: String {
    case ProductDetailMock
    case ProductMock
    case SitesMock
}

class RequestManagerMock: RequestManagerRepository {
    static var requestWasCalled = false
    static var lastRequestMade: RequestType?
    static var expectedResult: ModelMock?

    static func request(type: RequestType, completion: @escaping Response) {
        guard let mockName = expectedResult?.rawValue, let data = loadJsonMock(filename: mockName) else {
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

    static func resetMock() {
        lastRequestMade = nil
        requestWasCalled = false
        expectedResult = nil
    }

    static func loadJsonMock(filename fileName: String) -> Data? {
        guard let url = Bundle(for: self).path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let data = try? Data(contentsOf: URL(fileURLWithPath: url))
        return data
    }
}
