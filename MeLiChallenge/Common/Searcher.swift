//
//  Searcher.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 1/04/21.
//

import Foundation

struct Searcher {
    let requestManager: RequestManagerRepository.Type

    init(requestManager: RequestManagerRepository.Type) {
        self.requestManager = requestManager
    }

    func search(_ query: String, completion: @escaping (Result<[Product], ServiceError>) -> Void) {
        requestManager.getProducts(basedOn: query) { result in
            switch result {
            case .success(let data):
                guard let result = try? JSONDecoder().decode(SearchResult.self, from: data) else {
                    return
                }

                completion(.success(result.products))
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }

    func fetchSites(completion: @escaping (Result<[Site], ServiceError>) -> Void) {
        requestManager.getSites { result in
            switch result {
            case .success(let data):
                guard let result = try? JSONDecoder().decode([Site].self, from: data) else {
                    return
                }

                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}
