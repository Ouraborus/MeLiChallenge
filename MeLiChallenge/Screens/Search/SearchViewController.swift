//
//  SearchViewController.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 1/04/21.
//

import UIKit

class SearchViewController: UIViewController {
    private let viewModel = SearchViewModel(requestManager: RequestManager.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.didTapSearchButton()

    }

}
