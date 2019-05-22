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
    let editionCount: Int?
    let title: String?
    let authorNames: [String]
    let firstPublishYear: Int?
    let key: String?
    let publishers: [String]
}

extension Book: Decodable {
    enum Key: String, CodingKey {
        case coverId = "cover_i"
        case editionCount = "edition_count"
        case title
        case authorNames = "author_name"
        case firstPublishYear = "first_publish_year"
        case key
        case publisher
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.coverId = try container.decodeIfPresent(Int.self, forKey: Key.coverId)
        self.editionCount = try container.decodeIfPresent(Int.self, forKey: Key.editionCount)
        self.title = try container.decodeIfPresent(String.self, forKey: Key.title)
        self.authorNames = try container.decodeIfPresent([String].self, forKey: Key.authorNames) ?? []
        self.firstPublishYear = try container.decodeIfPresent(Int.self, forKey: Key.firstPublishYear)
        self.key = try container.decodeIfPresent(String.self, forKey: Key.key)
        self.publishers = try container.decodeIfPresent([String].self, forKey: Key.publisher) ?? []
    }
}

extension Book {
    init(model: BookModel) {
        self.title = model.title
        self.coverId = Int(model.coverId)
        self.editionCount = Int(model.editionCount)
        self.key = model.key
        self.firstPublishYear = Int(model.firstPublishYear)
        self.authorNames = model.authors?
            .compactMap { $0 as? AuthorModel }
            .compactMap { $0.name }
            ?? []
        self.publishers = model.publishers?
            .compactMap { $0 as? PublisherModel }
            .compactMap { $0.name }
            ?? []
    }
}
