//
//  ProductListViewModel.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 2/04/21.
//

import Foundation
import os

class ProductListViewModel: NSObject {
    private(set) var products: [Product] {
        didSet {
            delegate?.toggleEmptyView()
        }
    }

    let searcher: Searcher
    let logger: LoggerProtocol
    weak var delegate: ProductListDelegate?

    init(model: SearchResult, requestManager: RequestManagerRepository.Type, logger: LoggerProtocol) {
        self.products = model.products
        self.searcher = Searcher(requestManager: requestManager)
        self.logger = logger
    }

    func didTapSearchButton(query: String) {
        searcher.search(query) { [weak self] result in
            switch result {
            case .success(let searchResult):
                self?.products = searchResult.products
                self?.loadImages()
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.logger.logError(message: error.localizedDescription)
            }
        }
    }

    func viewDidLoad() {
        loadImages()
        delegate?.toggleEmptyView()
    }

    private func loadImages() {
        products.enumerated().forEach { index, product in
            searcher.requestManager.request(type: .image(product.thumbnail)) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.products[index].setImage(data: data)
                    self?.delegate?.reloadData()
                case .failure(let error):
                    self?.logger.logError(message: error.localizedDescription)
                }
            }
        }
    }
}
