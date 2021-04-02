//
//  SearchViewModel.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 1/04/21.
//

import Foundation
import UIKit

class SearchViewModel: NSObject {
    //var logger: LoggerProtocol
    private var searcher: Searcher
    var products: [Product]?

    init(requestManager: RequestManagerRepository.Type) {
        self.searcher = Searcher(requestManager: requestManager)
    }

    func didTapSearchButton(query: String) {
        searcher.search(query) { result in
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }

        didTapSearchButton(query: query)
    }
}

