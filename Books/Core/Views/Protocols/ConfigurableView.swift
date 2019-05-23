//
//  ConfigurableView.swift
//  Books
//
//  Created by Spencer Prescott on 5/23/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

/// View data model to populate content with
protocol DisplayItem {}

/// View that can be configured with display item
protocol ConfigurableView {
    associatedtype DisplayItemType: DisplayItem
    
    /// Hook to populate view outlets
    func configure(displayItem: DisplayItemType)
}
