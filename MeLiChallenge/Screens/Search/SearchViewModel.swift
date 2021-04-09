//
//  SearchViewModel.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 1/04/21.
//

import Foundation

class SearchViewModel: NSObject {
    let logger: LoggerProtocol
    let searcher: Searcher
    private(set) var sites: [Site]?
    weak var delegate: SearchViewDelegate?

    init(requestManager: RequestManagerRepository.Type, logger: LoggerProtocol) {
        self.searcher = Searcher(requestManager: requestManager)
        self.logger = logger
    }

    func viewDidLoad() {
        loadSites()
    }

    private func loadSites() {
        searcher.fetchSites() { [weak self] result in
            switch result {
            case .success(let sites):
                self?.sites = sites.sorted { $0.name < $1.name }
                self?.delegate?.reload()
            case .failure(let error):
                self?.logger.logError(message: error.localizedDescription)
            }
        }
    }
}
