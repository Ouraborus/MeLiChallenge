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
    weak var delegate: ProductListDelegate?

    init(model: SearchResult, requestManager: RequestManagerRepository.Type) {
        self.products = model.products
        self.searcher = Searcher(requestManager: requestManager)
    }

    func didTapSearchButton(query: String) {
        searcher.search(query) { result in
            switch result {
            case .success(let searchResult):
                self.products = searchResult.products
                self.loadImages()
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
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
                    print(error)
                }
            }
        }
    }
}
