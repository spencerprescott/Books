//
//  BookCoverImageView.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class BookCoverImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        kf.indicatorType = .activity
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Loads image from url into image view. If it fails, it will display the placeholder cover image
    func setImageUrl(_ url: URL?, completion: ((Result<UIImage, Error>) -> Void)? = nil) {
        kf.setImage(with: url) { [weak self] result in
            guard let self = self else { return }
            // If download fails, use placeholder image
            switch result {
            case .success(let value):
                completion?(.success(result: value.image))
            case .failure(let error):
                self.image = UIImage(named: "cover-placeholder")
                completion?(.failure(error: error))
            }
        }
    }
}
