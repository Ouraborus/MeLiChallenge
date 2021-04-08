//
//  ProductDetailViewModel+UICollection.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 7/04/21.
//

import Foundation
import UIKit

extension ProductDetailViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetail.pictures.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductPictureCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductPictureCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setupView(picture: UIImage(data: productDetail.pictures[indexPath.row].pictureData ?? Data()))
        return cell
    }
}

extension ProductDetailViewModel: UICollectionViewDelegateFlowLayout {
    private struct Constants {
        static let collectionViewItemHeight: CGFloat = 250
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: delegate?.view.frame.width ?? 0, height: Constants.collectionViewItemHeight)
    }
}
