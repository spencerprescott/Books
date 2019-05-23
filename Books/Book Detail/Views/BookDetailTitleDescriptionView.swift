//
//  BookDetailTitleDescriptionView.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class BookDetailTitleDescriptionView: UIView {
    private lazy var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return l
    }()
 
    private lazy var descriptionLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.numberOfLines = 0
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookDetailTitleDescriptionView: ConfigurableView {
    typealias DisplayItemType = BookDetailTitleDescriptionDisplayItem
    
    func configure(displayItem: BookDetailTitleDescriptionDisplayItem) {
        titleLabel.text = displayItem.title
        descriptionLabel.text = displayItem.description
    }
}
