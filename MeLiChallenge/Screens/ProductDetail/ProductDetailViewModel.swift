//
//  ProductDetailViewModel.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 3/04/21.
//

import Foundation
import UIKit

protocol ProductDetailViewControllerDelegate where Self: UIViewController {
    func reloadData()
}

class ProductDetailViewModel: NSObject {
    private struct Constants {
        static let collectionViewItemHeight: CGFloat = 250
    }

    private(set) var productDetail: ProductDetail
    private var productDetailImages: [String: UIImage] = [:]
    private var requestManager: RequestManagerRepository.Type
    weak var delegate: ProductDetailViewControllerDelegate?

    init(productDetail: ProductDetail, requestManager: RequestManagerRepository.Type) {
        self.productDetail = productDetail
        self.requestManager = requestManager
    }

    func viewDidLoad() {
        loadImages()
    }

    private func loadImages() {
        productDetail.pictures.forEach { picture in
            requestManager.request(type: .image(picture.url)) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.productDetailImages[picture.id] = UIImage(data: image)
                    self?.delegate?.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension ProductDetailViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetail.pictures.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductPictureCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductPictureCollectionViewCell else {
            return UICollectionViewCell()
        }

        let pictureId = productDetail.pictures[indexPath.row].id
        cell.setupView(picture: productDetailImages[pictureId])
        return cell
    }
}

extension ProductDetailViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: delegate?.view.frame.width ?? 0, height: Constants.collectionViewItemHeight)
    }
}
