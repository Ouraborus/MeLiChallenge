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
    weak var delegate: ProductDetailDelegate?

    init(productDetail: ProductDetail, requestManager: RequestManagerRepository.Type) {
        self.productDetail = productDetail
        self.requestManager = requestManager
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
                    print(error)
                }
            }
        }
    }
}
