//
//  RemoteColor.swift
//  Technical-test
//
//  Created by Andrew on 14.04.2023.
//

import UIKit

struct RemoteColor {
    
    let value: UIColor
    
    init(_ rawValue: String?) {
        if let remoteName = rawValue, let color = UIColor(named: remoteName) {
            self.value = color
        } else {
            self.value = .black
        }
    }
}
