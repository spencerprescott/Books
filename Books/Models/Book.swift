//
//  Book.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

struct Book {
    let coverId: Int?
    let hasFullText: Bool
    let editionCount: Int?
    let title: String?
    let authorNames: [String]
    let firstPublishYear: Int?
    let key: String?
    let ia: [String]
    let authorKeys: [String]
    let publicScanB: Bool
}

extension Book: Decodable {
    enum Key: String, CodingKey {
        case coverId = "cover_i"
        case hasFullText = "has_fulltext"
        case editionCount = "edition_count"
        case title
        case authorNames = "author_name"
        case firstPublishYear = "first_publish_year"
        case key
        case ia
        case authorKeys = "author_key"
        case publicScanB = "public_scan_b"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.coverId = try container.decodeIfPresent(Int.self, forKey: Key.coverId)
        self.hasFullText = try container.decodeIfPresent(Bool.self, forKey: Key.hasFullText) ?? false
        self.editionCount = try container.decodeIfPresent(Int.self, forKey: Key.editionCount)
        self.title = try container.decodeIfPresent(String.self, forKey: Key.title)
        self.authorNames = try container.decodeIfPresent([String].self, forKey: Key.authorNames) ?? []
        self.firstPublishYear = try container.decodeIfPresent(Int.self, forKey: Key.firstPublishYear)
        self.key = try container.decodeIfPresent(String.self, forKey: Key.key)
        self.ia = try container.decodeIfPresent([String].self, forKey: Key.ia) ?? []
        self.authorKeys = try container.decodeIfPresent([String].self, forKey: Key.authorKeys) ?? []
        self.publicScanB = try container.decodeIfPresent(Bool.self, forKey: Key.publicScanB) ?? false
    }
}
