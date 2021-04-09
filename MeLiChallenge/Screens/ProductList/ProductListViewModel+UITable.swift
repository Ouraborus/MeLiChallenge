//
//  ProductListViewModel+UITable.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 7/04/21.
//

import Foundation
import UIKit

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
                self?.logger.logError(message: error.localizedDescription)
            }
        }
    }
}

