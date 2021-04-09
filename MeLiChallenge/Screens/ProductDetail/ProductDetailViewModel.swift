//
//  ProductDetailViewModel.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 3/04/21.
//

import Foundation

class ProductDetailViewModel: NSObject {
    private(set) var productDetail: ProductDetail
    private var requestManager: RequestManagerRepository.Type
    private var logger: LoggerProtocol
    weak var delegate: ProductDetailDelegate?

    init(productDetail: ProductDetail, requestManager: RequestManagerRepository.Type, logger: LoggerProtocol) {
        self.productDetail = productDetail
        self.requestManager = requestManager
        self.logger = logger
    }

    func viewDidLoad() {
        loadImages()
    }

    private func loadImages() {
        productDetail.pictures.enumerated().forEach { index, picture in
            requestManager.request(type: .image(picture.url)) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.productDetail.pictures[index].setPicture(data: data)
                    self?.delegate?.reloadData()
                case .failure(let error):
                    self?.logger.logError(message: error.localizedDescription)
                }
            }
        }
    }
}
