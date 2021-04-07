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

    func search(_ query: String, completion: @escaping (Result<SearchResult, ServiceError>) -> Void) {
        requestManager.request(type: .products(query)) { result in
            switch result {
            case .success(let data):
                guard let result = try? JSONDecoder().decode(SearchResult.self, from: data) else {
                    return
                }

                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }

    func fetchSites(completion: @escaping (Result<[Site], ServiceError>) -> Void) {
        requestManager.request(type: .sites) { result in
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

    func getProductDetail(productId: String, completion: @escaping (Result<ProductDetail, ServiceError>) -> Void) {
        requestManager.request(type: .productDetail(productId)) { result in
            switch result {
            case .success(let data):
                guard let productDetail = try? JSONDecoder().decode(ProductDetail.self, from: data) else {
                    return
                }

                completion(.success(productDetail))
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}
