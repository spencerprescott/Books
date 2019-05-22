//
//  UITableView+CellReuse.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ cellClasses: [AnyClass]) {
        cellClasses.forEach { klass in
            let className = String(describing: klass)
            if Bundle(for: klass).path(forResource: className, ofType: "nib") != nil {
                let nib = UINib(nibName: className, bundle: Bundle(for: klass))
                self.register(nib, forCellReuseIdentifier: className)
            } else {
                self.register(klass, forCellReuseIdentifier: className)
            }
        }
    }
    
    func dequeue<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! T
    }
}
