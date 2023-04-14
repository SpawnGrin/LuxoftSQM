//
//  QuoteDetailsViewModel.swift
//  Technical-test
//
//  Created by Andrew on 14.04.2023.
//

import Foundation

protocol QuoteDetailsViewModelInput {
    func favotiteAction()
}

protocol QuoteDetailsViewModelOutput {
    var symbol: String { get }
    var name: String { get }
    var lastValue: String { get }
    var currency: String { get }
    var lastPercent: String { get }
    var percentColor: RemoteColor { get }
    var buttonTitle: String { get }
    var favoriteButtonTitleUpdated: Signal<String> { get }
}

protocol QuoteDetailsViewModel: QuoteDetailsViewModelOutput, QuoteDetailsViewModelInput {}

final class DefaultQuoteDetailsViewModel: QuoteDetailsViewModel {
    
    struct DTO {
        struct Related {
            var quote: Quote
            var favoriteCallback: () -> Void
        }
        var related: Related
    }
    
    // MARK: - QuoteDetailsViewModelOutput
    var symbol: String {
        data.related.quote.symbol ?? "-"
    }
    var name: String {
        data.related.quote.name ?? "-"
    }
    var lastValue: String {
        data.related.quote.lastValue ?? "-"
    }
    var currency: String {
        data.related.quote.currency ?? "-"
    }
    var lastPercent: String {
        data.related.quote.lastPercent ?? "-"
    }
    var percentColor: RemoteColor {
        data.related.quote.percentColor
    }
    var buttonTitle: String {
        data.related.quote.isFavorite ? "Favorites.Remove".localized : "Favorites.Add".localized
    }
    let favoriteButtonTitleUpdated: Signal<String> = .init()
    
    private var data: DTO
    
    init(data: DTO) {
        self.data = data
    }
}

// MARK: - QuoteDetailsViewModelInput
extension DefaultQuoteDetailsViewModel: QuoteDetailsViewModelInput {
    
    func favotiteAction() {
        data.related.quote.isFavorite.toggle()
        favoriteButtonTitleUpdated.accept(buttonTitle)
        data.related.favoriteCallback()
    }
}
