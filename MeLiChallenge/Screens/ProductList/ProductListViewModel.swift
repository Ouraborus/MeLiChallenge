//
//  ProductListViewModel.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 2/04/21.
//

import Foundation
import UIKit

protocol ProductListViewControllerDelegate where Self: UIViewController {
    func reloadData()
    func navigateTo(_ product: ProductDetail)
}

class ProductListViewModel: NSObject {
    private(set) var products: [Product]
    private let searcher: Searcher
    weak var delegate: ProductListViewControllerDelegate?

    init(model: SearchResult, requestManager: RequestManagerRepository.Type) {
        self.products = model.products
        self.searcher = Searcher(requestManager: requestManager)
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

    func viewDidLoad() {
        loadImages()
    }

    private func didTapSearchButton(query: String) {
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
}

extension ProductListViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }

        didTapSearchButton(query: query)
    }
}

extension ProductListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !products.isEmpty, let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.reuseIdentifier) as? ProductListTableViewCell else {
            return UITableViewCell()
        }

        let product = products[indexPath.row]
        cell.setupView(title: product.title, price: String(product.price), thumbnail: UIImage(data: product.imageData ?? Data()))
        return cell
    }
}

extension ProductListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searcher.getProductDetail(productId: self.products[indexPath.row].id) { [weak self] result in
            switch result {
            case .success(let productDetail):
                self?.delegate?.navigateTo(productDetail)
            case .failure(let error):
                print(error)
            }
        }
    }
}
