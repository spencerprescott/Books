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
            return buildWishListFlow()
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
    
    private func buildWishListFlow() -> WishListFlow {
        let storage = WishListStorage(dataStore: dataStore)
        let presenter = WishListPresenter(storage: storage)
        return WishListFlow(presenter: presenter)
    }
    
    private func buildBookDetailFlow(book: Book) -> BookDetailFlow {
        let storage = BookDetailStorage(dataStore: dataStore)
        let presenter = BookDetailPresenter(book: book, storage: storage)
        return BookDetailFlow(presenter: presenter)
    }
}
