//
//  SearchViewDelegate.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 7/04/21.
//

import Foundation
import UIKit

protocol SearchViewDelegate where Self: UIViewController {
    func reload()
    func userTappedSearch(_ result: SearchResult)
}
