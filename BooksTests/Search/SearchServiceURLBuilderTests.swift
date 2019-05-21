//
//  SearchServiceURLBuilderTests.swift
//  BooksTests
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import XCTest
@testable import Books

class SearchServiceURLBuilderTests: XCTestCase {
    func testValidUrlIsBuilt() {
        guard let url = SearchService.URLBuilder().query("hello world").build() else {
            return XCTFail("Expected url to be generated. Got nil url instead")
        }
        
        XCTAssertFalse(url.absoluteString.contains("page="), "Expected page to not be set")
        XCTAssertTrue(url.absoluteString.contains("?q=hello+world"), "Expected url to have q=hello+world")
    }
    
    func testValidUrlIsBuiltWithMultipleSpaces() {
        guard let url = SearchService.URLBuilder().query("hello     world").build() else {
            return XCTFail("Expected url to be generated. Got nil url instead")
        }
        
        XCTAssertFalse(url.absoluteString.contains("page="), "Expected page to not be set")
        XCTAssertTrue(url.absoluteString.contains("?q=hello+world"), "Expected url to have q=hello+world")
    }
    
    func testValidUrlIsBuiltWithPage() {
        guard let url = SearchService.URLBuilder().page(2).build() else {
            return XCTFail("Expected url to be generated. Got nil url instead")
        }
        
        XCTAssertFalse(url.absoluteString.contains("q="), "Expected url to not have query set")
        XCTAssertTrue(url.absoluteString.contains("?page=2"), "Expected url to have page set to page=2")
    }
    
    func testValidUrlIsBuiltWithPageAndQuery() {
        guard let url = SearchService.URLBuilder().query("hello world").page(2).build() else {
            return XCTFail("Expected url to be generated. Got nil url instead")
        }
        
        XCTAssertTrue(url.absoluteString.contains("q=hello+world"), "Expected url to have q=hello+world")
        XCTAssertTrue(url.absoluteString.contains("page=2"), "Expected url to have page set to page=2")
    }
}
