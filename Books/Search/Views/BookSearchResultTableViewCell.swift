//
//  BookSearchResultTableViewCell.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit
import Kingfisher

final class BookSearchResultTableViewCell: UITableViewCell {
    private lazy var coverImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.kf.indicatorType = .activity
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // Cover Image View Constraints
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            coverImageView.heightAnchor.constraint(equalToConstant: 50),
            coverImageView.widthAnchor.constraint(equalToConstant: 30),
            // Title Label Constraints
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15)
        ])
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

    func configure(displayItem: BookSearchDisplayItem) {
        titleLabel.text = displayItem.title
        coverImageView.kf.setImage(with: displayItem.imageUrl)
    }
}
