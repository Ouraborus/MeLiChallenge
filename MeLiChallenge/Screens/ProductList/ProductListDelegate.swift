//
//  ProductListDelegate.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 7/04/21.
//

import Foundation
import UIKit

protocol ProductListDelegate where Self: UIViewController {
    func reloadData()
    func navigateTo(_ product: ProductDetail)
    func toggleEmptyView()
}
