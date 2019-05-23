//
//  LoadingFooterView.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit
import SnapKit

final class LoadingFooterView: UIView {
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        v.hidesWhenStopped = true
        v.startAnimating()
        return v
    }()

    init() {
        super.init(frame: .zero)
        addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
