//
//  SearchViewModel.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 1/04/21.
//

import Foundation

class SearchViewModel {
    //var logger: LoggerProtocol
    private var searcher: Searcher
    var products: [Product]? {
        didSet {
            print(products)
        }
    }

    init(requestManager: RequestManagerRepository.Type) {
        self.searcher = Searcher(requestManager: requestManager)
    }

    func didTapSearchButton() {
        searcher.search(query: "Tarjeta Grafica Msi Rx 6700 Xt Gaming X 12g Nueva Sellada") { result in
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                print(error)
            }
        }
    }
}

