//
//  UITableView+Extensions.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cell: T.Type) {
        register(cell, forCellReuseIdentifier: cell.className)
    }
    
    func reuse<CellType: UITableViewCell>(_ cellType: CellType.Type, for indexPath: IndexPath) -> CellType {
        dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! CellType
    }
}
