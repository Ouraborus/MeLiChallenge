//
//  SearchBarViewModel+UISearchBar.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 7/04/21.
//

import Foundation
import UIKit

extension SearchViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }

        didTapSearchButton(query: query)
    }

    private func didTapSearchButton(query: String) {
        searcher.search(query) { [weak self] result in
            switch result {
            case .success(let searchResult):
                self?.delegate?.userTappedSearch(searchResult)
            case .failure(let error):
                self?.logger.logError(message: error.localizedDescription)
            }
        }
    }
}
