//
//  Quote.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

struct Quote {
    var name: String?
    var symbol: String?
    var lastValue: String?
    var currency: String?
    var lastPercent: String?
    var percentColor: RemoteColor
    var isFavorite: Bool
}

extension Quote {
    init(from remoteObject: QuoteResponseModel) {
        self.name = remoteObject.name
        self.symbol = remoteObject.symbol
        self.lastValue = remoteObject.last
        self.currency = remoteObject.currency
        self.lastPercent = remoteObject.readableLastChangePercent
        self.percentColor = .init(remoteObject.variationColor)
        self.isFavorite = false
    }
}
