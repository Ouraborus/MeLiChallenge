//
//  SearchViewModelTests.swift
//  MeLiChallengeTests
//
//  Created by Esteban Cardona Alvarez on 6/04/21.
//

import XCTest
@testable import MeLiChallenge

class SearchViewModelTests: XCTestCase {
    let requestManager = RequestManagerMock.self
    lazy var searchViewModel = SearchViewModel(requestManager: requestManager)

    override func tearDown() {
        requestManager.resetMock()
    }

    func testSearchBarViewModelViewDidLoadShouldRequestSites() {
        // Given
        requestManager.expectedResult = .SitesMock

        // When
        searchViewModel.viewDidLoad()

        //Then
        guard let lastRequestMade = requestManager.lastRequestMade else {
            XCTFail("Request was not made")
            return
        }

        XCTAssertEqual(lastRequestMade, RequestType.sites, "Last Request Made is not the same as the expected site request type")
    }

    func testSearchBarViewModelViewDidLoadShouldUpdateSites() {
        // Given
        requestManager.expectedResult = .SitesMock
        let expectedNumberOfSites = 19

        // When
        searchViewModel.viewDidLoad()

        //Then
        guard let sites = searchViewModel.sites else {
            XCTFail("Sites should not be nil")
            return
        }

        XCTAssertEqual(sites.count, expectedNumberOfSites, "Sites count didn't match the expected number of sites: \(expectedNumberOfSites)")
    }
}
