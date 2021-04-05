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
    private var productImages: [String: UIImage] = [:]
    private let searcher: Searcher
    weak var delegate: ProductListViewControllerDelegate?

    init(products: [Product], requestManager: RequestManagerRepository.Type) {
        self.products = products
        self.searcher = Searcher(requestManager: requestManager)
    }

    func loadImages() {
        products.forEach { product in
            searcher.requestManager.request(type: .image(product.thumbnail)) { [weak self] result in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data, scale: 80) else {
                        return
                    }

                    self?.productImages[product.id] = image
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

    func didTapSearchButton(query: String) {
        searcher.search(query) { result in
            switch result {
            case .success(let products):
                self.products = products
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
        cell.setupView(title: product.title, price: String(product.price), thumbnail: productImages[product.id])
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
