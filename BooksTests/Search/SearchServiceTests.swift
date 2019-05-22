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
    private class MockNetworkRequest: NetworkRequest {
        func executeRequest() {}
        func cancelRequest() {}
    }
    private class MockNetworkService: NetworkServicing {
        private let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func buildRequest(url: URL, resultHandler: @escaping (Result<Data, NetworkError>) -> Void) -> NetworkRequest {
            resultHandler(.success(result: data))
            return MockNetworkRequest()
        }
    }
    
    private let service = SearchService(networkService: MockNetworkService(data: BookSearchContainer.mockData))
    
    func testResponseDataIsParsedToBookSearchContainer() {
        service.search(query: "test", page: 1) { result in
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
        service.search(query: nil, page: 1) { result in
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
    
 
    func testPageNumberIsSet() {
        service.search(query: nil, page: 3) { result in
            switch result {
            case .success(let searchResult):
                XCTAssertEqual(searchResult.page, 3)
                XCTAssertEqual(searchResult.nextPage, 4)
            case .failure(let error):
                XCTFail("Did not parse did succesfully: \(error.localizedDescription)")
            }
        }
    }
}
