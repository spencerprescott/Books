//
//  UIImage+Color.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

extension UIImage {
    static func make(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let image = renderer.image { context in
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.fill(rect)
        }
        
        return image
    }
}
