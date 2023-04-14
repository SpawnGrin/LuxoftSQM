//
//  ScreenFactory.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import UIKit

enum Scene {
    case quotesList(AppCoordinatorDelegate)
    case quotesDetails(DefaultQuoteDetailsViewModel.DTO.Related)
}

final class ScreenFactory {
    
    private let networkService: BaseNetworkService
    
    private lazy var dataSource: MarketDataSourceProtocol = MarketDataSource(networkService: networkService)
    
    init(networkService: BaseNetworkService) {
        self.networkService = networkService
    }
    
    public func create(scene: Scene) -> UIViewController {
        switch scene {
        case let .quotesList(coordinatorDelegate):
            return QuotesListViewController(
                dataSource: .init(fetchQuotes: { [dataSource] result in
                    dataSource.fetchQuotes { response in
                        result(response)
                    }
                }),
                navigation: .init(followDetails: { related in
                    coordinatorDelegate.followDetails(related)
                })
            )
        case let .quotesDetails(related):
            return QuoteDetailsViewController(related: related)
        }
    }
}
