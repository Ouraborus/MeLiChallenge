//
//  ProductDetailView.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 3/04/21.
//

import UIKit

class ProductDetailView: UIStackView {

    func setupView(attributes: [Attribute]) {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        spacing = 0

        attributes.forEach { attribute in
            let attributeView = getViewFor(attribute: attribute)
            addArrangedSubview(attributeView)
            layoutSubviews()
        }
    }

    private func getViewFor(attribute: Attribute) -> UIView {
        let attributeName = UILabel()
        let attributeValue = UILabel()
        let attributeView = UIView()

        attributeName.text = attribute.name
        attributeValue.text = attribute.valueName
        attributeName.textColor = .black
        attributeValue.textColor = .black

        attributeView.addSubview(attributeName)
        attributeView.addSubview(attributeValue)

        attributeName.translatesAutoresizingMaskIntoConstraints = false
        attributeValue.translatesAutoresizingMaskIntoConstraints = false
        attributeView.translatesAutoresizingMaskIntoConstraints = false

        attributeName.topAnchor.constraint(equalTo: attributeView.topAnchor, constant: 5).isActive = true
        attributeName.leadingAnchor.constraint(equalTo: attributeView.leadingAnchor, constant: 5).isActive = true
        attributeName.trailingAnchor.constraint(equalTo: attributeView.trailingAnchor, constant: -5).isActive = true

        attributeValue.topAnchor.constraint(equalTo: attributeName.bottomAnchor, constant: 5).isActive = true
        attributeValue.leadingAnchor.constraint(equalTo: attributeName.leadingAnchor, constant: 5).isActive = true
        attributeValue.trailingAnchor.constraint(equalTo: attributeName.trailingAnchor, constant: 5).isActive = true
        attributeValue.bottomAnchor.constraint(equalTo: attributeView.bottomAnchor, constant: -5).isActive = true
        return attributeView
    }

}
