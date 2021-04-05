//
//  ProductListTableViewCell.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 2/04/21.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    private struct Constants {
        static let thumbnailSize: CGFloat = 80
        static let thumbnailTopAnchor: CGFloat = 20
        static let thumbnailLeadingAnchor: CGFloat = 20
        static let thumbnailBottomAnchor: CGFloat = -20
        static let titleLeadingAnchor: CGFloat = 20
        static let titleTrailingAnchor: CGFloat = -20
        static let titleBottomAnchor: CGFloat = -20
        static let titleNumberOfLines: Int = 2
    }

    static let reuseIdentifier = String(describing: ProductListTableViewCell.self)

    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = Constants.titleNumberOfLines
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
        return thumbnail
    }()

    func setupView(title: String, price: String, thumbnail: UIImage?) {
        self.thumbnail.image = thumbnail
        self.title.text = title
        self.price.text = price

        contentView.addSubview(self.thumbnail)
        contentView.addSubview(self.title)
        contentView.addSubview(self.price)

        self.thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.thumbnailTopAnchor).isActive = true
        self.thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.thumbnailLeadingAnchor).isActive = true
        self.thumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.thumbnailBottomAnchor).isActive = true
        self.thumbnail.heightAnchor.constraint(equalToConstant: Constants.thumbnailSize).isActive = true
        self.thumbnail.widthAnchor.constraint(equalToConstant: Constants.thumbnailSize).isActive = true

        self.title.topAnchor.constraint(equalTo: self.thumbnail.topAnchor).isActive = true
        self.title.leadingAnchor.constraint(equalTo: self.thumbnail.trailingAnchor, constant: Constants.titleLeadingAnchor).isActive = true
        self.title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: Constants.titleTrailingAnchor).isActive = true
        self.title.bottomAnchor.constraint(equalTo: self.price.topAnchor, constant: Constants.titleBottomAnchor).isActive = true

        self.price.leadingAnchor.constraint(equalTo: self.title.leadingAnchor).isActive = true
        self.price.trailingAnchor.constraint(lessThanOrEqualTo: self.title.trailingAnchor).isActive = true
    }

    override func prepareForReuse() {
        self.thumbnail.image = nil
        self.title.text = nil
        self.price.text = nil
    }
}
