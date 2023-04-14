//
//  QuotesListViewModel.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import Foundation

protocol QuotesListViewModelInput {
    func refreshData()
    func rowDidSeleted(with path: IndexPath)
    func quote(by path: IndexPath) -> QuoteCell.DTO
}

protocol QuotesListViewModelOutput {
    var defaultErrorAlertTitle: String { get }
    var localizedTitle: String { get }
    var errorFetched: Signal<String> { get }
    var listUpdated: Signal<Void> { get }
    var quoteCount: Int { get }
}

protocol QuotesListViewModel: QuotesListViewModelOutput, QuotesListViewModelInput {}

final class DefaultQuotesListViewModel: QuotesListViewModel {
    
    struct DTO {
        struct Related {
            var localizedTitle = "QuotesList.Title".localized
        }
        struct DataSource {
            let fetchQuotes: (_ callback: @escaping ((Result<[Quote], APIError>) -> Void)) -> Void
        }
        struct Navigation {
            let followDetails: (DefaultQuoteDetailsViewModel.DTO.Related) -> Void
        }
        let related: Related
        let source: DataSource
        let navigation: Navigation
    }
    
    // MARK: - QuotesListViewModelOutput
    let defaultErrorAlertTitle: String = "GeneralError.Title".localized
    let errorFetched: Signal<String> = .init()
    let listUpdated: Signal<Void> = .init()
    var localizedTitle: String {
        data.related.localizedTitle
    }
    var quoteCount: Int {
        quotesList.count
    }
    
    private var quotesList = [Quote]()
    
    private let data: DTO
    
    init(data: DTO) {
        self.data = data
        
        loadItems()
    }
    
    private func loadItems() {
        data.source.fetchQuotes { [weak self] result in
            switch result {
            case let .success(list):
                self?.quotesList = list
                self?.listUpdated.sendSignal()
            case let .failure(error):
                self?.errorFetched.accept(error.localizedDescription)
            }
        }
    }
}

// MARK: - MasterViewModelInput
extension DefaultQuotesListViewModel: QuotesListViewModelInput {
    
    func quote(by path: IndexPath) -> QuoteCell.DTO {
        .init(from: quotesList[path.row])
    }
    
    func rowDidSeleted(with path: IndexPath) {
        data.navigation.followDetails(.init(
            quote: quotesList[path.row],
            favoriteCallback: { [weak self] in
                self?.quotesList[path.row].isFavorite.toggle()
                self?.listUpdated.sendSignal()
            }
        ))
    }
    
    func refreshData() {
        loadItems()
    }
}
