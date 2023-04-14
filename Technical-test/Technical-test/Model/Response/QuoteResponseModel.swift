//
//  QuoteResponseModel.swift
//  Technical-test
//
//  Created by Andrew on 14.04.2023.
//

import Foundation

struct QuoteResponseModel: Decodable {
    var name: String?
    var symbol: String?
    var last: String?
    var currency: String?
    var readableLastChangePercent: String?
    var variationColor: String?
}
