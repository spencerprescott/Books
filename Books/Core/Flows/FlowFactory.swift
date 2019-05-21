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
        case detail
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
        case .detail:
            return EmptyFlow()
        }
    }
    
    // MARK:- Builders
    
    private func buildSearchFlow() -> SearchFlow {
        let searchService = SearchService(networkService: networkService)
        return SearchFlow(presenter: SearchPresenter(searchService: searchService))
    }
}
