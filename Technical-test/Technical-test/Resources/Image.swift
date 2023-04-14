//
//  Image.swift
//  Technical-test
//
//  Created by Andrew on 14.04.2023.
//

import UIKit

final class Image {
    static var favorite: UIImage { getIcon(named: "favorite") }
    static var notFavorite: UIImage { getIcon(named: "no-favorite") }
    
    private static func getIcon(named: String) -> UIImage {
        (UIImage(named: named, in: Bundle(for: Image.self), compatibleWith: nil) ?? .init())
    }
}
