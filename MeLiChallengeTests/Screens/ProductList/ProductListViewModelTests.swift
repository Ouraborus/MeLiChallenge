//
//  ProductListViewModelTests.swift
//  MeLiChallengeTests
//
//  Created by Esteban Cardona Alvarez on 6/04/21.
//

import XCTest
@testable import MeLiChallenge

class ProductListViewModelTests: XCTestCase {
    let requestManager = RequestManagerMock.self

    override func tearDown() {
        requestManager.resetMock()
    }

    func testProductListViewModelViewDidLoadShouldRequestImageWithThumbnailURL() {
        // Given
        requestManager.expectedResult = .ProductMock
        let expectedThumbnail = "url.mock"
        let searchResult = SearchResult(siteId: "", query: "", products: [Product(id: "", title: "", price: 0.0, permalink: "", thumbnail: expectedThumbnail, imageData: nil)])
        let productListViewModel = ProductListViewModel(model: searchResult, requestManager: requestManager)

        // When
        productListViewModel.viewDidLoad()

        //Then
        guard let lastRequestMade = requestManager.lastRequestMade else {
            XCTFail("Request was not made")
            return
        }

        XCTAssertEqual(lastRequestMade, RequestType.image(expectedThumbnail), "Last Request Made is not the same as the expected site request type")
    }

    func testProductListViewModelDidTapSearchButtonShouldUpdateProducts() {
        // Given
        requestManager.expectedResult = .ProductMock
        let expectedNumberOfProducts = 50
        let searchResult = SearchResult(siteId: "", query: "", products: [Product(id: "", title: "", price: 0.0, permalink: "", thumbnail: "", imageData: nil)])
        let productListViewModel = ProductListViewModel(model: searchResult, requestManager: requestManager)

        // When
        productListViewModel.didTapSearchButton(query: "anyQuery")

        //Then
        XCTAssertEqual(productListViewModel.products.count, expectedNumberOfProducts, "Expected number of products is \(expectedNumberOfProducts)")
    }
}
