//
//  ApiResources.swift
//  AOK
//
//  Created by Osman Ashraf on 17.12.21.
//

import Foundation
import Combine


/**
 The mainAPI Helper, which inject the protocol and passing the data to the Viewmodel.
 */

struct APIResources : APIResourcesProtocol {
    
    static let scheme = "https"
    static let host = "api.github.com"
    static let path = "/orgs/apple/"
    
    enum EndPoint : String {
        case repos
    }
    
    enum TypeKey : String {
        case type
    }
    
    //building the Url components for the URlsession Call
    static var urlComponents : URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        return urlComponents
    }
    
    //wihtout any query
    static func url(with endpoint : EndPoint) -> URL? {
        if let url = urlComponents.url {
            return url.appendingPathComponent(endpoint.rawValue)
        }
        else {
            return nil
        }
    }
    
    //wiht query
    static func urlWithQuery(for endpoint : EndPoint, typekey : TypeKey,type : String) -> URL? {
        var componts = urlComponents
        componts.path = path + endpoint.rawValue
        componts.setQueryItems(with: [typekey.rawValue :type])
        return componts.url
    }
    
    func createReposPublisher() -> AnyPublisher<[Repositorie], APIError> {
        if let url = APIResources.urlWithQuery(for: .repos, typekey: .type, type: "owner"){
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap({ (data,response) ->Data in
                    if let response = response as? HTTPURLResponse,!(200...299).contains(response.statusCode) {
                        throw APIError.badResponse(statuscode: response.statusCode)
                    }
                    else {
                        print(data)
                        return data
                    }
                })
                .decode(type: [Repositorie].self, decoder: JSONDecoder())
                .sort{ $0.watchers_countWrapped > $1.watchers_countWrapped }
                .mapError({ APIError.convert(error: $0)})
                .eraseToAnyPublisher()
        }
        else {
            return Fail(error: APIError.badUrl)
                    .eraseToAnyPublisher()
        }
    }
}


extension URLComponents {
    mutating func setQueryItems(with parameters : [String : String]){
        self.queryItems = parameters.map({
            URLQueryItem(name: $0.key, value: $0.value)
        })
    }
}


extension Publisher where Output: Sequence {
    typealias Sorter = (Output.Element, Output.Element) -> Bool

    func sort(
        by sorter: @escaping Sorter
    ) -> Publishers.Map<Self, [Output.Element]> {
        map { sequence in
            sequence.sorted(by: sorter)
        }
    }
}
