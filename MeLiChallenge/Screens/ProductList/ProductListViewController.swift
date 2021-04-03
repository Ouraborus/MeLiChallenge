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
        productList.translatesAutoresizingMaskIntoConstraints = false
        productList.rowHeight = UITableView.automaticDimension
        productList.register(ProductListTableViewCell.self, forCellReuseIdentifier: ProductListTableViewCell.reuseIdentifier)
        return productList
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
        setupView()
        //viewModel.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidLoad()
    }

    private func setupView() {
        view.backgroundColor = UIColor(red: 0.99, green: 0.86, blue: 0.23, alpha: 1.00)
        navigationItem.titleView = searchBarView
        view.addSubview(productListTableView)

        productListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        productListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        productListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        productListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ProductListViewController: ProductListViewControllerDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.productListTableView.reloadData()
        }
    }
}
