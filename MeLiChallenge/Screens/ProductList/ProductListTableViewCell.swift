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
        static let stackLeadingAnchor: CGFloat = 20
        static let stackTrailingAnchor: CGFloat = -20
        static let stackBottomAnchor: CGFloat = -20
        static let stackSpacing: CGFloat = 20
    }

    static let reuseIdentifier = String(describing: ProductListTableViewCell.self)

    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
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
        thumbnail.contentMode = .scaleAspectFit
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        return thumbnail
    }()

    private lazy var productPreviewStack: UIStackView = {
        let productPreviewDetail = UIStackView()
        productPreviewDetail.translatesAutoresizingMaskIntoConstraints = false
        productPreviewDetail.axis = .vertical
        productPreviewDetail.alignment = .fill
        productPreviewDetail.distribution = .fillProportionally
        productPreviewDetail.spacing = Constants.stackSpacing
        productPreviewDetail.addArrangedSubview(self.title)
        productPreviewDetail.addArrangedSubview(self.price)
        return productPreviewDetail
    }()

    func setupView(title: String, price: String, thumbnail: UIImage?) {
        self.thumbnail.image = thumbnail
        self.title.text = title
        self.price.text = price

        contentView.addSubview(self.thumbnail)
        contentView.addSubview(productPreviewStack)

        self.thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.thumbnailTopAnchor).isActive = true
        self.thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.thumbnailLeadingAnchor).isActive = true
        self.thumbnail.heightAnchor.constraint(equalToConstant: Constants.thumbnailSize).isActive = true
        self.thumbnail.widthAnchor.constraint(equalToConstant: Constants.thumbnailSize).isActive = true

        productPreviewStack.topAnchor.constraint(equalTo: self.thumbnail.topAnchor).isActive = true
        productPreviewStack.leadingAnchor.constraint(equalTo: self.thumbnail.trailingAnchor, constant: Constants.stackLeadingAnchor).isActive = true
        productPreviewStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.stackTrailingAnchor).isActive = true
        productPreviewStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.stackBottomAnchor).isActive = true
    }

    override func prepareForReuse() {
        self.thumbnail.image = nil
        self.title.text = nil
        self.price.text = nil
    }
}
