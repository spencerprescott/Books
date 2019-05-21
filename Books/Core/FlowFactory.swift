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
    
    init(dataStore: DataStoring) {
        self.dataStore = dataStore
    }
    
    func flow(flowType: FlowType) -> Flow {
        switch flowType {
        case .search:
            return SearchFlow(presenter: SearchPresenter())
        case .wishList:
            return SearchFlow(presenter: SearchPresenter())
        case .detail:
            return SearchFlow(presenter: SearchPresenter())
        }
    }
}
