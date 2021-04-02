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
        static let headerLabelTopAnchor: CGFloat = 50
        static let headerLabelLeadingAnchor: CGFloat = 10
        static let headerLabelTrailingAnchor: CGFloat = -10
        static let headerLabelBottomAnchor: CGFloat = -10
        static let searchBarLeading: CGFloat = 5
        static let searchBarTrailing: CGFloat = -5
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

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarView.delegate = viewModel
        setupView()
    }

    private func setupView() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = Constants.backgroundColor
        searchBarView.setupView()
        view.addSubview(headerLabel)
        view.addSubview(searchBarView)

        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.headerLabelTopAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.headerLabelLeadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.headerLabelTrailingAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(greaterThanOrEqualTo: searchBarView.topAnchor, constant: Constants.headerLabelBottomAnchor).isActive = true

        searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.searchBarLeading).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.searchBarTrailing).isActive = true
        searchBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBarView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
