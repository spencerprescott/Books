//
//  SearchServiceTests.swift
//  BooksTests
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import XCTest
@testable import Books

class SearchServiceTests: XCTestCase {
    private class MockNetworkService: NetworkServicing {
        private let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func executeRequest(url: URL, resultHandler: @escaping (Result<Data, Error>) -> Void) {
            resultHandler(.success(result: data))
        }
    }
    
    private let service = SearchService(networkService: MockNetworkService(data: BookSearchContainer.mockData))
    
    func testResponseDataIsParsedToBookSearchContainer() {
        service.search(query: "test", page: nil) { result in
            switch result {
            case .success(let searchResult):
                // Using data from BookSearchContainer.mockData
                XCTAssertEqual(searchResult.container.numFound, 1)
                XCTAssertEqual(searchResult.container.start, 0)
                XCTAssertEqual(searchResult.container.books.count, 1)
            case .failure(let error):
                XCTFail("Did not parse did succesfully: \(error.localizedDescription)")
            }
        }
    }
    
    func testEmptyResultIsReturnedWithNilQuery() {
        service.search(query: nil, page: nil) { result in
            switch result {
            case .success(let searchResult):
                XCTAssertEqual(searchResult.container.numFound, BookSearchContainer.empty.numFound)
                XCTAssertEqual(searchResult.container.start, BookSearchContainer.empty.start)
                XCTAssertEqual(searchResult.container.books.count, BookSearchContainer.empty.books.count)
            case .failure(let error):
                XCTFail("Did not parse did succesfully: \(error.localizedDescription)")
            }
        }
    }
    
    func testPageNumberIsSetWhenNil() {
        service.search(query: nil, page: nil) { result in
            switch result {
            case .success(let searchResult):
                XCTAssertEqual(searchResult.page, 1)
            case .failure(let error):
                XCTFail("Did not parse did succesfully: \(error.localizedDescription)")
            }
        }
    }
    
    func testPageNumberIsSetWhenNonNil() {
        service.search(query: nil, page: 3) { result in
            switch result {
            case .success(let searchResult):
                XCTAssertEqual(searchResult.page, 3)
            case .failure(let error):
                XCTFail("Did not parse did succesfully: \(error.localizedDescription)")
            }
        }
    }
}
