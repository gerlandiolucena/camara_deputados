//
//  BaseRequest.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import Foundation
import Combine

class BaseRequest<BaseResult: Decodable> {
    let urlString = "https://dadosabertos.camara.leg.br/api"
    var endpointUrl: String { .empty }
    var query: String { .empty }
    var customQueries: [String: String]?
    var customPaths: [String: String]?
    var publisher: AnyPublisher<BaseResult?, Error>?
    var cancellable: Cancellable?
    
    var finalURL: URL? {
        let resultado = customQueries?.toQuery ?? ""
        let finalEndpointUrl = endpointUrl.replacementPath(paths: customPaths ?? [:])
        return URL(string: urlString + finalEndpointUrl + query + resultado)
    }
    
    init() {
        setupRequest()
    }
    
    func setupRequest() {
        if let urlQuery = finalURL {
            let request = URLRequest(url: urlQuery, timeoutInterval: 10.0)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            self.publisher = session.dataTaskPublisher(for: request)
                .handleEvents(receiveOutput: { print(NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)!) })
                .map {
                    $0.data
                }
                .decode(type: BaseResult.self, decoder: JSONDecoder())
                .tryMap({ $0 })
                .eraseToAnyPublisher()
        }
    }
    
    func request<Root>(to: ReferenceWritableKeyPath<Root, BaseResult?>, on: Root, customQueries: [String: String]? = nil, customPaths: [String: String]? = nil) {
        if let queries = customQueries, self.customQueries != nil {
            self.customQueries = (self.customQueries ?? [:]).merging(queries, uniquingKeysWith: { _, merged in merged })
        } else {
            self.customQueries = customQueries
        }
        
        self.customPaths = customPaths
        setupRequest()
        self.cancellable = publisher?.receive(on: DispatchQueue.main)
            .replaceError(with: replaceError())
            .assign(to: to, on: on)
    }
    
    func replaceError() -> BaseResult? {
        nil
    }
}
