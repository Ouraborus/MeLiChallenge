//
//  RequestManager.swift
//  MeLiChallenge
//
//  Created by Esteban Cardona Alvarez on 31/03/21.
//

import Foundation

class RequestManager: RequestManagerRepository {
    
    private struct Constants {
        static let defaultSite = "MLA"
        static let urlFormat = "https://api.mercadolibre.com/sites/%@/search?q=%@"
        static let sitesUrl = "https://api.mercadolibre.com/sites"
        static let productDetailUrl = "https://api.mercadolibre.com/items/%@"
        static let selectedSite = "site.selected"
    }

    static func setSite(siteId: String?) {
        UserDefaults.standard.setValue(siteId, forKey: Constants.selectedSite)
    }

    static func getSelectedSite() -> String {
        return UserDefaults.standard.value(forKey: Constants.selectedSite) as? String ?? Constants.defaultSite
    }

    static func request(type: RequestType, completion: @escaping Response) {
        let url: String?

        switch type {
        case .products(let query):
            url = String(format: Constants.urlFormat, getSelectedSite(), query).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        case .productDetail(let productId):
            url = String(format: Constants.productDetailUrl, productId)
        case .image(let path):
            url = path
        case .sites:
            url = Constants.sitesUrl
        }

        guard let urlPath = url, let request = buildURLRequest(with: urlPath) else {
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
