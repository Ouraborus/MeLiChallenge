//
//  SearchBarView.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 1/04/21.
//

import UIKit

class SearchBarView: UISearchBar {

    private struct Constants {
        static let searchBarDefaultText = "Busca productos, marcas y más..."
        static let searchBarColor = UIColor(red: 0.96, green: 0.96, blue: 0.90, alpha: 1.00)
        static let searchBarShadowColor: CGColor = UIColor.black.cgColor
        static let searchBarShadowOpacity: Float = 0.15
        static let searchBarShadowOffset: CGSize =  CGSize(width: 0, height: 2)
        static let searchBarShadowRadius: CGFloat = 5
    }

    func setupView() {
        placeholder = Constants.searchBarDefaultText
        searchTextField.backgroundColor = Constants.searchBarColor
        searchBarStyle = .minimal
        topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
