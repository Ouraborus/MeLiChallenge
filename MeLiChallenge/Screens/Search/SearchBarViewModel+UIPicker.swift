//
//  SearchBarViewModel+UIPicker.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 7/04/21.
//

import Foundation
import UIKit

extension SearchViewModel: UIPickerViewDelegate {
    private(set) var selectedSite: String? {
        get {
            return searcher.requestManager.getSelectedSite()
        }

        set {
            searcher.requestManager.setSite(siteId: newValue)
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSite = sites?[row].id
    }
}

extension SearchViewModel: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sites?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sites?[row].name
    }
}
