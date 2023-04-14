//
//  MarketDataSource.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import Foundation

private enum Endpoint {
    static let quotes = "mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=SMI&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq"
}

protocol MarketDataSourceProtocol {
    func fetchQuotes(_ result: @escaping (Result<[Quote], APIError>) -> Void)
}

final class MarketDataSource: MarketDataSourceProtocol {
    
    let networkService: BaseNetworkService
    
    init(networkService: BaseNetworkService) {
        self.networkService = networkService
    }
    
    func fetchQuotes(_ result: @escaping (Result<[Quote], APIError>) -> Void) {
        switch networkService.request(with: Endpoint.quotes) {
        case let.success(request):
            networkService.perform(RequestModel(request, .get, nil)) { response in
                switch response {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let remoteQuotes = try decoder.decode([QuoteResponseModel].self, from: data)
                        result(.success(remoteQuotes.compactMap { .init(from: $0) }))
                    } catch {
                        result(.failure(.init(.parsingError)))
                    }
                case let .failure(serverError):
                    result(.failure(serverError))
                }
            }
        case let .failure(error):
            result(.failure(error))
        }
    }
}
