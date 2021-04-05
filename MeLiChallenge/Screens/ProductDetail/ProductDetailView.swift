//
//  ProductDetailView.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 3/04/21.
//

import UIKit

class ProductDetailView: UIStackView {

    private struct Constants {
        static let attributeTopAnchor: CGFloat = 5
        static let attributeLeadingAnchor: CGFloat = 5
        static let attributeTrailingAnchor: CGFloat = -5
    }

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

        attributeView.addSubview(attributeName)
        attributeView.addSubview(attributeValue)

        attributeName.translatesAutoresizingMaskIntoConstraints = false
        attributeValue.translatesAutoresizingMaskIntoConstraints = false
        attributeView.translatesAutoresizingMaskIntoConstraints = false

        attributeName.topAnchor.constraint(equalTo: attributeView.topAnchor, constant: Constants.attributeTopAnchor).isActive = true
        attributeName.leadingAnchor.constraint(equalTo: attributeView.leadingAnchor, constant: Constants.attributeLeadingAnchor).isActive = true
        attributeName.trailingAnchor.constraint(equalTo: attributeView.trailingAnchor, constant: Constants.attributeTrailingAnchor).isActive = true

        attributeValue.topAnchor.constraint(equalTo: attributeName.bottomAnchor, constant: Constants.attributeTopAnchor).isActive = true
        attributeValue.leadingAnchor.constraint(equalTo: attributeName.leadingAnchor, constant: Constants.attributeLeadingAnchor).isActive = true
        attributeValue.trailingAnchor.constraint(equalTo: attributeName.trailingAnchor).isActive = true
        attributeValue.bottomAnchor.constraint(equalTo: attributeView.bottomAnchor, constant: Constants.attributeTrailingAnchor).isActive = true
        return attributeView
    }
}
