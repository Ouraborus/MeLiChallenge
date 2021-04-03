//
//  ProductListTableViewCell.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 2/04/21.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProductListTableViewCell.self)

    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        return title
    }()

    private lazy var price: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.numberOfLines = 0
        return price
    }()

    private lazy var thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        //thumbnail.contentMode = .scaleAspectFill
        return thumbnail
    }()

    func setupView(title: String, price: String, thumbnail: UIImage) {
        self.thumbnail.image = thumbnail
        self.title.text = title
        self.price.text = price

        contentView.addSubview(self.thumbnail)
        contentView.addSubview(self.title)
        contentView.addSubview(self.price)

        self.thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        self.thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        self.thumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        self.thumbnail.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.thumbnail.widthAnchor.constraint(equalToConstant: 80).isActive = true

        self.title.topAnchor.constraint(equalTo: self.thumbnail.topAnchor).isActive = true
        self.title.leadingAnchor.constraint(equalTo: self.thumbnail.trailingAnchor, constant: 20).isActive = true
        self.title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20).isActive = true
        self.title.bottomAnchor.constraint(equalTo: self.price.topAnchor, constant: -20).isActive = true

        self.price.leadingAnchor.constraint(equalTo: self.title.leadingAnchor).isActive = true
        self.price.trailingAnchor.constraint(lessThanOrEqualTo: self.title.trailingAnchor).isActive = true
    }
}
