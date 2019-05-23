//
//  BookSearchResultTableViewCell.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

final class BookSearchResultTableViewCell: UITableViewCell {
    private lazy var coverImageView = BookCoverImageView()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 3
        l.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        
        coverImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(18)
            make.leading.equalTo(coverImageView.snp.trailing).offset(18)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.kf.cancelDownloadTask()
        coverImageView.image = nil
        titleLabel.text = nil
    }
}

extension BookSearchResultTableViewCell: ConfigurableView {
    typealias DisplayItemType = BookSearchDisplayItem
    
    func configure(displayItem: BookSearchDisplayItem) {
        titleLabel.text = displayItem.title
        coverImageView.setImageUrl(displayItem.imageUrl)
    }
}
