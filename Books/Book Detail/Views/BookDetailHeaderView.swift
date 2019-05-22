//
//  BookDetailHeaderView.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class BookDetailHeaderView: UIView {
    private lazy var imageView: UIImageView = {
        let v = UIImageView(frame: .zero)
        v.kf.indicatorType = .activity
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private lazy var backgroundImageView = UIImageView(frame: .zero)
    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        return UIVisualEffectView(effect: effect)
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.numberOfLines = 0
        l.textAlignment = .center
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return l
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(blurView)
        blurView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundImageView)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(200)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(displayItem: BookDetailHeaderDisplayItem) {
        titleLabel.text = displayItem.title
        imageView.kf.setImage(with: displayItem.imageUrl) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                // Set background image
                self.backgroundImageView.image = value.image
            case .failure:
                // If download fails, use placeholder image
                self.imageView.image = UIImage(named: "cover-placeholder")
            }
        }
    }
}
