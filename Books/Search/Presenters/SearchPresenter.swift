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
    weak var view: SearchViewable?
    
    private let searchService: SearchServicing
    /// Page user is currently viewing
    private var page: Int = 1
    /// Query the user is currently searcing for
    private var query: String?
    /// Books loaded from search request
    private var books: [Book] = []
    
    init(searchService: SearchServicing) {
        self.searchService = searchService
    }
    
    // MARK:- SearchPresentable
    
    func search(query: String?) {
        // Reset search parameters and results
        books = []
        page = 1
        self.query = query
        
        executeSearchRequest(on: page)
    }
    
    func loadNextPage() {
        executeSearchRequest(on: page + 1)
    }
    
    func didSelectBook(at index: Int) {
        let book = books[index]
    }
    
    // MARK:- Helpers
    
    private func executeSearchRequest(on page: Int) {
        searchService.search(query: query, page: page) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let searchResult):
                    self.handleSearchResult(searchResult)
                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }
    
    private func handleError(_ error: Error) {
        guard let networkError = error as? NetworkError else {
            view?.showError(message: error.localizedDescription)
            return
        }
        
        // Only show alert if the request errored not from being cancelled
        switch networkError {
        case .cancelled:
            break
        default:
            view?.showError(message: networkError.localizedDescription)
        }
    }
    
    private func handleSearchResult(_ result: SearchResult) {
        // Increment to next page
        self.page = result.nextPage
        
        // Add new books to data source
        self.books.append(contentsOf: result.container.books)
        
        // Create display items
        let displayItems: [BookSearchDisplayItem] = self.books
            .map { book in
                let imageUrl: URL? = {
                    if let id = book.coverId {
                        return URL(string: "http://covers.openlibrary.org/b/ID/\(id)-S.jpg")
                    }
                    return nil
                }()
                return BookSearchDisplayItem(imageUrl: imageUrl,
                                             title: book.title ?? "Unknown")
            }
        
        let dataSource = SearchDataSource(items: displayItems)
        // Notify view of new display items to show
        view?.showSearchResults(dataSource: dataSource)
    }
}
