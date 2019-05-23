//
//  BookDetailMoreInfoView.swift
//  Books
//
//  Created by Spencer Prescott on 5/23/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class BookDetailMoreInfoView: UIView {
    private lazy var publishYearTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Year Published"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return l
    }()
    
    private lazy var publishYearValueLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return l
    }()
    
    private lazy var editionCountTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Editions"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return l
    }()
    
    private lazy var editionCountValueLabel: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return l
    }()
    
    private lazy var separatorView = UIView(backgroundColor: .groupTableViewBackground)
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        let publishYearStackView = buildSectionStackView(titleLabel: publishYearTitleLabel, valueLabel: publishYearValueLabel)
        let editionCountStackView = buildSectionStackView(titleLabel: editionCountTitleLabel, valueLabel: editionCountValueLabel)

        addSubview(separatorView)
        addSubview(publishYearStackView)
        addSubview(editionCountStackView)
        
        separatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(18)
            make.width.equalTo(1)
        }
        
        publishYearStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(separatorView).inset(5)
            make.leading.equalToSuperview().inset(18)
            make.trailing.equalTo(separatorView.snp.leading)
        }
        
        editionCountStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(separatorView).inset(5)
            make.leading.equalTo(separatorView.snp.trailing)
            make.trailing.equalToSuperview().inset(18)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildSectionStackView(titleLabel: UILabel, valueLabel: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        return stackView
    }
}

extension BookDetailMoreInfoView: ConfigurableView {
    typealias DisplayItemType = BookDetailMoreInfoDisplayItem
    
    func configure(displayItem: BookDetailMoreInfoDisplayItem) {
        publishYearValueLabel.text = displayItem.publishYear
        editionCountValueLabel.text = displayItem.editionCount
    }
}
