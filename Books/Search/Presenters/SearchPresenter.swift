//
//  SearchPresenter.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

protocol SearchPresentable: class {
    var view: SearchViewable? { get set }
    
    func search(query: String?)
    func loadNextPage()
    func didSelectBook(at index: Int)
}

final class SearchPresenter: SearchPresentable {
    private let searchService: SearchServicing
    /// Page user is currently viewing
    private var page: Int = 1
    /// Query the user is currently searcing for
    private var query: String?
    /// Books loaded from search request
    private var books: [Book] = []
    weak var view: SearchViewable?
    
    init(searchService: SearchServicing) {
        self.searchService = searchService
    }
    
    // MARK:- SearchPresentable
    
    func search(query: String?) {
        // Reset search parameters and results
        books = []
        page = 1
        self.query = query
        
        // Execute new search request
        searchService.search(query: query, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let searchResult):
                self.handleSearchResult(searchResult)
            case .failure(let error):
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func loadNextPage() {
        page += 1
        searchService.search(query: query, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let searchResult):
                self.handleSearchResult(searchResult)
            case .failure(let error):
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func didSelectBook(at index: Int) {
        let book = books[index]
    }
    
    // MARK:- Helpers
    
    private func handleSearchResult(_ result: SearchResult) {
        self.books.append(contentsOf: result.container.books)
        let displayItems: [BookSearchDisplayItem] = result.container.books
            .map { book in
                let imageUrl = URL(string: "http://covers.openlibrary.org/b/ID/\(book.coverId)-S.jpg")
                return BookSearchDisplayItem(imageUrl: imageUrl,
                                             title: book.title)
            }
        view?.showSearchResults(displayItems)
    }
}