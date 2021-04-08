//
//  SearchViewController.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 1/04/21.
//

import UIKit

class SearchViewController: UIViewController {

    private struct Constants {
        static let headerLabelCopy = "MeLi\n Challenge"
        static let headerLabelFont = UIFont(name: "Futura-CondensedExtraBold", size: 50) ?? UIFont()
        static let headerLabelTopAnchor: CGFloat = 10
        static let headerLabelLeadingAnchor: CGFloat = 10
        static let headerLabelTrailingAnchor: CGFloat = -10
        static let headerLabelBottomAnchor: CGFloat = -20
        static let searchBarLeading: CGFloat = 5
        static let searchBarTrailing: CGFloat = -5
        static let pickerViewTopAnchor: CGFloat = 20
        static let pickerViewBottomAnchor: CGFloat = -20
        static let backgroundColor = UIColor(red: 0.99, green: 0.86, blue: 0.23, alpha: 1.00)
    }

    private let viewModel = SearchViewModel(requestManager: RequestManager.self)

    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = .center
        let attribute = [ NSAttributedString.Key.font: Constants.headerLabelFont ]
        let attributedString = NSAttributedString(string: Constants.headerLabelCopy, attributes: attribute)

        headerLabel.attributedText = attributedString
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()

    private lazy var searchBarView: SearchBarView = {
        let searchBar = SearchBarView()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var sitePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        searchBarView.delegate = viewModel
        sitePickerView.delegate = viewModel
        sitePickerView.dataSource = viewModel
        setupView()
        viewModel.viewDidLoad()
    }

    private func setupView() {
        view.backgroundColor = Constants.backgroundColor
        searchBarView.setupView()
        view.addSubview(headerLabel)
        view.addSubview(searchBarView)
        view.addSubview(sitePickerView)

        setupNavigationController()
        setupHeaderLabel()
        setupSearchBarView()
        setupSitePickerView()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = Constants.backgroundColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Constants.backgroundColor
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func setupHeaderLabel() {
        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.headerLabelTopAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.headerLabelLeadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.headerLabelTrailingAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(greaterThanOrEqualTo: searchBarView.topAnchor, constant: Constants.headerLabelBottomAnchor).isActive = true
    }

    private func setupSearchBarView() {
        searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.searchBarLeading).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.searchBarTrailing).isActive = true
        searchBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBarView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func setupSitePickerView() {
        sitePickerView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: Constants.pickerViewTopAnchor).isActive = true
        sitePickerView.centerXAnchor.constraint(equalTo: searchBarView.centerXAnchor).isActive = true
        sitePickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.pickerViewBottomAnchor).isActive = true
    }
}

extension SearchViewController: SearchViewDelegate {
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.sitePickerView.reloadAllComponents()

            guard let lastSelectedSiteId = self?.viewModel.selectedSite else {
                return
            }

            let index = self?.viewModel.sites?.firstIndex { $0.id == lastSelectedSiteId } ?? 0
            self?.sitePickerView.selectRow(index, inComponent: 0, animated: true)
        }
    }

    func userTappedSearch(_ result: SearchResult) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = ProductListViewModel(model: result, requestManager: RequestManager.self)
            let controller = ProductListViewController(viewModel: viewModel)

            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
