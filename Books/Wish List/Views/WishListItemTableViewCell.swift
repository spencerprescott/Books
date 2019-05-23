//
//  WishListItemTableViewCell.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class WishListItemTableViewCell: UITableViewCell {
    private lazy var coverImageView = BookCoverImageView()

    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 3
        l.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return l
    }()
    
    private lazy var dateAddedLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 1
        l.font = UIFont.systemFont(ofSize: 16)
        l.textColor = .gray
        return l
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coverImageView)
        
        let textStackView = UIStackView(arrangedSubviews: [titleLabel, dateAddedLabel])
        textStackView.axis = .vertical
        contentView.addSubview(textStackView)
        
        coverImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(50)
        }
        
        textStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(18)
            make.leading.equalTo(coverImageView.snp.trailing).offset(18)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WishListItemTableViewCell: ConfigurableView {
    typealias DisplayItemType = WishListDisplayItem
    
    func configure(displayItem: WishListDisplayItem) {
        titleLabel.text = displayItem.title
        dateAddedLabel.text = displayItem.dateAdded
        coverImageView.setImageUrl(displayItem.imageUrl)
    }
}
