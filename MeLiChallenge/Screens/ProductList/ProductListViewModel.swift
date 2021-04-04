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
    func navigateTo(_ product: Product)
}

class ProductListViewModel: NSObject {
    private(set) var products: [Product]
    private let searcher: Searcher
    weak var delegate: ProductListViewControllerDelegate?

    init(products: [Product], requestManager: RequestManagerRepository.Type) {
        self.products = products
        self.searcher = Searcher(requestManager: requestManager)
    }

    func loadImage(url: String, completion: @escaping (Result<UIImage, ServiceError>) -> Void)  {
        searcher.requestManager.request(type: .image(url)) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data, scale: 80) else {
                    completion(.failure(.unableToParse))
                    return
                }
                
                completion(.success(image))
            case .failure(let error):
                print(error)
            }
        }
    }

    func viewDidLoad() {
        delegate?.reloadData()
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

        loadImage(url: product.thumbnail, completion: { result in
            var thumbnail = UIImage()
            switch result {
            case .success(let image):
                thumbnail = image
            case .failure(let error):
                print(error)
            }

            DispatchQueue.main.async {
                cell.setupView(title: product.title, price: String(product.price), thumbnail: thumbnail)
            }
        })

        return cell
    }
}

extension ProductListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.navigateTo(self.products[indexPath.row])
    }
}
