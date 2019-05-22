//
//  FlowFactory.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

final class FlowFactory {
    enum FlowType {
        case search
        case wishList
        case detail(book: Book)
    }
    
    private let dataStore: DataStoring
    private let networkService: NetworkServicing
    
    init(dataStore: DataStoring = DataStore.shared,
         networkService: NetworkServicing = NetworkService.shared) {
        self.dataStore = dataStore
        self.networkService = networkService
    }
    
    func flow(flowType: FlowType) -> Flow {
        switch flowType {
        case .search:
            return buildSearchFlow()
        case .wishList:
            return EmptyFlow()
        case .detail(let book):
            return buildBookDetailFlow(book: book)
        }
    }
    
    // MARK:- Builders
    
    private func buildSearchFlow() -> SearchFlow {
        let searchService = SearchService(networkService: networkService)
        let presenter = SearchPresenter(searchService: searchService)
        return SearchFlow(presenter: presenter)
    }
    
    private func buildBookDetailFlow(book: Book) -> BookDetailFlow {
        let presenter = BookDetailPresenter(book: book)
        return BookDetailFlow(presenter: presenter)
    }
}
