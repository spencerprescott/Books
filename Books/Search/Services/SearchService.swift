//
//  SearchService.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

protocol SearchServicing: class {
    func search(query: String?, page: Int, resultHandler: @escaping (Result<SearchResult, Error>) -> Void)
}

struct SearchError: LocalizedError {
    let errorDescription: String?
}

final class SearchService: SearchServicing {
    final class URLBuilder {
        private let baseUrl = "http://openlibrary.org/search.json"
        private var query: String?
        private var page: Int = 1
        
        func query(_ query: String) -> URLBuilder {
            // Replace all whitespace with plus signs
            self.query = query
                .components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
                .joined(separator: "+")
            return self
        }
        
        func page(_ page: Int) -> URLBuilder {
            self.page = page
            return self
        }
        
        func build() -> URL? {
            var components = URLComponents(string: baseUrl)
            var queryItems: [URLQueryItem] = []
            queryItems.append(.init(name: "page", value: "\(page)"))
       
            if let query = query {
                queryItems.append(.init(name: "q", value: query))
            }
            
            components?.queryItems = queryItems
            return components?.url
        }
    }
    
    private let networkService: NetworkServicing
    
    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
    
    func search(query: String?, page: Int, resultHandler: @escaping (Result<SearchResult, Error>) -> Void) {
        guard let query = query
            else { return resultHandler(.success(result: SearchResult(page: page, container: .empty))) }
        
        let url = URLBuilder()
            .page(page)
            .query(query)
            .build()
        
        guard let searchUrl = url
            else { return resultHandler(.failure(error: SearchError(errorDescription: "Invalid Search Query"))) }
        
        networkService.executeRequest(url: searchUrl) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let searchResult = try self.parseSearchResult(from: data, page: page)
                    resultHandler(.success(result: searchResult))
                } catch {
                    resultHandler(.failure(error: error))
                }
            case .failure(let error):
                resultHandler(.failure(error: error))
            }
        }
    }
    
    private func parseSearchResult(from data: Data, page: Int?) throws -> SearchResult {
        let container = try JSONDecoder().decode(BookSearchContainer.self, from: data)
        return SearchResult(page: page, container: container)
    }
}