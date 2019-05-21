//
//  BookSearchResultTableViewCell.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class BookSearchResultTableViewCell: UITableViewCell {
    private lazy var coverImageView: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return l
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(displayItem: BookSearchDisplayItem) {
        titleLabel.text = displayItem.title
        // TODO: Set image
    }
}
