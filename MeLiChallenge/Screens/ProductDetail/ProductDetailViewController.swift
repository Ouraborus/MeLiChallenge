//
//  ProductDetailViewController.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 3/04/21.
//

import UIKit

class ProductDetailViewController: UIViewController {

    private struct Constants {
        static let productPicturesCarouselHeight: CGFloat = 250
        static let productDetailViewTopAnchor: CGFloat = 20
        static let productDetailViewLeadingAnchor: CGFloat = 15
        static let productDetailViewTrailingAnchor: CGFloat = -15
    }

    private let viewModel: ProductDetailViewModel

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var carouselLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private lazy var productPicturesCarousel: UICollectionView = {
        let carousel = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        carousel.translatesAutoresizingMaskIntoConstraints = false
        carousel.dataSource = viewModel
        carousel.delegate = viewModel
        carousel.showsVerticalScrollIndicator = false
        carousel.isPagingEnabled = true
        carousel.register(ProductPictureCollectionViewCell.self, forCellWithReuseIdentifier: ProductPictureCollectionViewCell.reuseIdentifier)
        return carousel
    }()

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        return containerView
    }()

    private lazy var productDetailView: ProductDetailView = {
        let detailView = ProductDetailView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.setupView(attributes: viewModel.productDetail.attributes)
        return detailView
    }()

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        setupView()
    }

    private func setupView() {
        containerView.addSubview(productPicturesCarousel)
        containerView.addSubview(productDetailView)
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)

        scrollView.backgroundColor = .white
        view.backgroundColor = .white

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true


        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        productPicturesCarousel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        productPicturesCarousel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        productPicturesCarousel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        productPicturesCarousel.heightAnchor.constraint(equalToConstant: Constants.productPicturesCarouselHeight).isActive = true

        productDetailView.topAnchor.constraint(equalTo: productPicturesCarousel.bottomAnchor, constant: Constants.productDetailViewTopAnchor).isActive = true
        productDetailView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.productDetailViewLeadingAnchor).isActive = true
        productDetailView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.productDetailViewTrailingAnchor).isActive = true
        productDetailView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}

extension ProductDetailViewController: ProductDetailDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.productPicturesCarousel.reloadData()
        }
    }
}
