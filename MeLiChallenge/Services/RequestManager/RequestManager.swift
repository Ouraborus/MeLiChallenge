//
//  RequestManager.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 31/03/21.
//

import Foundation

class RequestManager: RequestManagerRepository {

    private struct Constants {
        static let siteId = "MLA"
        static let urlFormat = "https://api.mercadolibre.com/sites/%@/search?q=%@"
        static let sitesUrl = "https://api.mercadolibre.com/sites"
    }

    static func getProducts(basedOn productName: String, completion: @escaping Response) {
        guard let url = String(format: Constants.urlFormat, Constants.siteId, productName).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let request = buildURLRequest(with: url) else {
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

    static func getSites(completion: @escaping Response) {
        guard let request = buildURLRequest(with: Constants.sitesUrl) else {
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
