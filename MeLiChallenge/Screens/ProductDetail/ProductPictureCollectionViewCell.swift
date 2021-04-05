//
//  ProductPictureCollectionViewCell.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 3/04/21.
//

import UIKit

class ProductPictureCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ProductPictureCollectionViewCell.self)

    private lazy var picture: UIImageView = {
        let picture = UIImageView()
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleAspectFill
        return picture
    }()

    func setupView(picture: UIImage?) {
        contentView.addSubview(self.picture)
        self.picture.image = picture
        self.picture.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.picture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        self.picture.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        self.picture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    override func prepareForReuse() {
        self.picture.image = nil
    }
}
