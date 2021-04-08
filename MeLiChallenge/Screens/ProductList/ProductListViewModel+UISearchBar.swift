//
//  ProductListViewModel+UISearchBar.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 7/04/21.
//

import Foundation
import UIKit

extension ProductListViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }

        didTapSearchButton(query: query)
    }
}
