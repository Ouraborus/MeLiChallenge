//
//  RequestManager.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 31/03/21.
//

import Foundation

class RequestManager: RequestManagerProtocol {

    private struct Constants {
        static let urlFormat = "https://api.mercadolibre.com/sites/MLA/search?q=Motorola%20G6"
    }

    static func getProducts(completion: @escaping ProductResponse) {
        let url = Constants.urlFormat

        guard let request = buildURLRequest(with: url) else {
            completion(.failure(.badUrl))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(.failure(.badData))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }

    private static func buildURLRequest(with query: String) -> URLRequest? {
        guard let url = URL(string: query) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = ServiceMethod.get.rawValue

        return request
    }
}
