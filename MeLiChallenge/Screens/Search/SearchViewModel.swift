//
//  SearchViewModel.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 1/04/21.
//

import Foundation
import UIKit

protocol SearchViewDelegate where Self: UIViewController {
    func reload()
}

class SearchViewModel: NSObject {
    //var logger: LoggerProtocol
    private var searcher: Searcher
    private(set) var products: [Product]?
    private(set) var sites: [Site]?
    weak var delegate: SearchViewDelegate?

    init(requestManager: RequestManagerRepository.Type) {
        self.searcher = Searcher(requestManager: requestManager)
    }

    func viewDidLoad() {
        loadSites()
    }

    func loadSites() {
        searcher.fetchSites() { [self] result in
            switch result {
            case .success(let sites):
                self.sites = sites.sorted { $0.name < $1.name }
                self.delegate?.reload()
            case .failure(let error):
                print(error)
            }
        }
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

extension SearchViewModel: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.setValue(sites?[row].id, forKey: "site.selected")
    }

}

extension SearchViewModel: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sites?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sites?[row].name
    }
}
