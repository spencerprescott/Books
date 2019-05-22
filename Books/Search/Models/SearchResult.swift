//
//  SearchResult.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

struct SearchResult {
    let page: Int
    let nextPage: Int
    let container: BookSearchContainer
}

struct BookSearchContainer {
    let start: Int
    let numFound: Int
    let books: [Book]
    
    static let empty: BookSearchContainer = BookSearchContainer(start: 0, numFound: 0, books: [])

    init(start: Int, numFound: Int, books: [Book]) {
        self.start = start
        self.numFound = numFound
        self.books = books
    }
}

extension BookSearchContainer: Decodable {
    enum Key: String, CodingKey {
        case start
        case numFound = "num_found"
        case books = "docs"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.start = try container.decode(Int.self, forKey: Key.start)
        self.numFound = try container.decode(Int.self, forKey: Key.numFound)
        self.books = try container.decode([Book].self, forKey: Key.books)
    }
}
