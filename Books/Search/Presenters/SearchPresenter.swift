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
    private let flowFactory: FlowFactory
    /// Page user is currently viewing
    private var page: Int = 1
    /// Query the user is currently searcing for
    private var query: String?
    /// Books loaded from search request
    private var books: [Book] = []
    
    init(searchService: SearchServicing, flowFactory: FlowFactory) {
        self.searchService = searchService
        self.flowFactory = flowFactory
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
        let detailFlow = flowFactory.flow(flowType: .detail(book: book))
        view?.viewFlow(detailFlow, displayStyle: .push)
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
        
    
        let dataSource = SearchDataSource(books: books)
        // Notify view of new display items to show
        view?.showSearchResults(dataSource: dataSource)
    }
}
