//
//  NSObject+Extensions.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import Foundation

extension NSObject {
    var className: String {
        String(describing: type(of: self))
    }
    
    class var className: String {
        String(describing: self)
    }
}
