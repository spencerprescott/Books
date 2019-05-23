//
//  BookSearchDisplayItem.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

/// Representation of what is displayed to user on the books search results page
struct BookSearchDisplayItem: DisplayItem {
    let imageUrl: URL?
    let title: String
}
