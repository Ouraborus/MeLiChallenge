//
//  ProductDetailViewModelTests.swift
//  MeLiChallengeTests
//
//  Created by Esteban Cardona Alvarez on 6/04/21.
//

import XCTest
@testable import MeLiChallenge

class ProductDetailViewModelTests: XCTestCase {
    let requestManager = RequestManagerMock.self

    override func tearDown() {
        requestManager.resetMock()
    }

    func testProductDetailViewModelViewDidLoadShouldRequestImageWithThumbnailURL() {
        // Given
        requestManager.expectedResult = .ProductDetailMock
        let expectedThumbnail = "url.mock"
        let pictures = [Picture(id: "", url: expectedThumbnail, pictureData: nil)]
        let productDetail = ProductDetail(id: "", title: "", price: 0.0, currencyId: "", pictures: pictures, attributes: [])
        let productListViewModel = ProductDetailViewModel(productDetail: productDetail, requestManager: requestManager)

        // When
        productListViewModel.viewDidLoad()

        //Then
        guard let lastRequestMade = requestManager.lastRequestMade else {
            XCTFail("Request was not made")
            return
        }

        XCTAssertEqual(lastRequestMade, RequestType.image(expectedThumbnail), "Last Request Made is not the same as the expected site request type")
    }
}
