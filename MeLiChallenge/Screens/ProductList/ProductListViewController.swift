//
//  ProductListViewController.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 2/04/21.
//

import UIKit

class ProductListViewController: UIViewController {

    private let viewModel: ProductListViewModel

    private lazy var searchBarView: SearchBarView = {
        let searchBar = SearchBarView()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.setupView()
        return searchBar
    }()

    private lazy var productListTableView: UITableView = {
        let productList = UITableView()
        productList.dataSource = viewModel
        productList.delegate = viewModel
        productList.translatesAutoresizingMaskIntoConstraints = false
        productList.rowHeight = UITableView.automaticDimension
        productList.register(ProductListTableViewCell.self, forCellReuseIdentifier: ProductListTableViewCell.reuseIdentifier)
        return productList
    }()

    private lazy var productListEmptyView: ProductListEmptyView = {
        let emptyView = ProductListEmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.backgroundColor = .white
        return emptyView
    }()

    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        searchBarView.delegate = viewModel
        setupView()
        viewModel.viewDidLoad()
    }

    private func setupView() {
        navigationItem.titleView = searchBarView
        view.addSubview(productListTableView)
        setupProductListTableView()
    }

    private func setupProductListTableView() {
        productListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        productListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        productListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        productListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupEmptyView() {
        productListEmptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        productListEmptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        productListEmptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        productListEmptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        productListEmptyView.setupView()
    }
}

extension ProductListViewController: ProductListDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.productListTableView.reloadData()
        }
    }

    func navigateTo(_ product: ProductDetail) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = ProductDetailViewModel(productDetail: product, requestManager: RequestManager.self)
            let controller = ProductDetailViewController(viewModel: viewModel)

            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }

    func toggleEmptyView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }

            if self.viewModel.products.isEmpty {
                self.productListTableView.removeFromSuperview()
                self.view.addSubview(self.productListEmptyView)
                self.setupEmptyView()
            } else {
                self.view.addSubview(self.productListTableView)
                self.setupProductListTableView()
                self.productListEmptyView.removeFromSuperview()
            }
        }
    }
}
