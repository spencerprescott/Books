//
//  MockSearchResult.swift
//  BooksTests
//
//  Created by Spencer Prescott on 5/23/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
@testable import Books

extension SearchResult {
    static func mock(data: Data = BookSearchContainer.mockData, page: Int = 1) -> SearchResult {
        do {
            let container = try JSONDecoder().decode(BookSearchContainer.self, from: data)
            return SearchResult(page: page, nextPage: page + 1, container: container)
        } catch {
            print("Failed to mock BookSearchContainer")
            let container = BookSearchContainer(start: 0, numFound: 0, books: [])
            return SearchResult(page: page, nextPage: page + 1, container: container)
        }
    }
}
