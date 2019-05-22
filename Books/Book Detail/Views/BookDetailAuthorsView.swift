//
//  BookDetailAuthorsView.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class BookDetailAuthorsView: UIView {
    private lazy var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return l
    }()
 
    private lazy var authorsLabel: UILabel = {
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
        
        addSubview(authorsLabel)
        authorsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(displayItem: BookDetailAuthorsDisplayItem) {
        titleLabel.text = displayItem.title
        authorsLabel.text = displayItem.authors
    }
}
