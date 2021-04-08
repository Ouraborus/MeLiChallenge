//
//  ProductListEmptyView.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 8/04/21.
//

import UIKit

class ProductListEmptyView: UIView {
    private struct Constants {
        static let emptyViewDisclaimer = "Nada por aquí 😥\n Intenta otra búsqueda..."
    }
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textAlignment = .center
        return title
    }()
    
    func setupView() {
        backgroundColor = .white
        addSubview(title)
        
        title.text = Constants.emptyViewDisclaimer
        
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
