//
//  String+Extensions.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}
