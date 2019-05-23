//
//  UIStackView+Utilities.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

extension UIStackView {
    func addSeparatorView(backgroundColor: UIColor = .groupTableViewBackground, height: CGFloat = 8) {
        let view = UIView(backgroundColor: backgroundColor)
        view.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        addArrangedSubview(view)
    }
}
