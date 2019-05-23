//
//  SearchPresenterTests.swift
//  BooksTests
//
//  Created by Spencer Prescott on 5/23/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import XCTest
import CoreData
@testable import Books

class SearchPresenterTests: XCTestCase {
    private let networkService = MockNetworkService(data: BookSearchContainer.mockData)
    private lazy var flowFactory: FlowFactory = {
        return FlowFactory(dataStore: MockDataStore(), networkService: networkService)
    }()
    
    func testSearchQueryNotifiesSearchService() {
        let (presenter, searchService) = buildComponents()
        // Execute query
        let query = "Hello"
        presenter.search(query: query)
        XCTAssertEqual(query, searchService.query)
        XCTAssertEqual(1, searchService.page)
    }
    
    func testLoadingNextPageUpdatesPageAndUsesSameQuery() {
        let (presenter, searchService) = buildComponents()
        // Execute query
        let query = "Hello"
        presenter.search(query: query)
        // Load next page
        presenter.loadNextPage()
        XCTAssertEqual(query, searchService.query)
        XCTAssertEqual(2, searchService.page)
    }
    
    func testViewIsUpdatedWhenBooksAreFound() {
        let (presenter, _) = buildComponents()
        let view = MockView(presenter: presenter)
        presenter.view = view
        // Execute query
        let query = "Hello"
        presenter.search(query: query)
        
        // Check if search results were viewed
        XCTAssertTrue(view.didShowSearchResults)
    }
    
    func testSelectingBookNotifiesView() {
        let (presenter, _) = buildComponents()
        let view = MockView(presenter: presenter)
        presenter.view = view
        // Set books
        let query = "Hello"
        presenter.search(query: query)
        presenter.didSelectBook(at: 0)
        
        // Check if view is told to route to flow
        XCTAssertTrue(view.flowViewed is BookDetailFlow)
    }

    
    // MARK:- Helpers
    
    private func buildComponents(result: Result<SearchResult, Error> = .success(result: SearchResult.mock())) -> (SearchPresenter, MockSearchService) {
        let searchService = MockSearchService(result: result)
        let presenter = SearchPresenter(searchService: searchService, flowFactory: flowFactory)
        return (presenter, searchService)
    }
}

// MARK:- Mock Search Classes

final private class MockSearchService: SearchServicing {
    var query: String?
    var page: Int?
    
    let result: Result<SearchResult, Error>
    
    init(result: Result<SearchResult, Error>) {
        self.result = result
    }
    
    func search(query: String?, page: Int, resultHandler: @escaping (Result<SearchResult, Error>) -> Void) {
        self.query = query
        self.page = page
        resultHandler(result)
    }
}

final class MockView: SearchViewable {
    var didShowSearchResults = false
    var flowViewed: Flow?
    
    private let presenter: SearchPresenter
    init(presenter: SearchPresenter) {
        self.presenter = presenter
    }
    
    func showSearchResults(dataSource: SearchDataSource) {
        didShowSearchResults = true
    }
    
    func viewFlow(_ flow: Flow, displayStyle: DisplayStyle) {
        flowViewed = flow
    }
    
    func showError(message: String) {}
}
