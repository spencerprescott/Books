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
}

final class SearchPresenter: SearchPresentable {
    private let searchService: SearchServicing
    weak var view: SearchViewable?
    
    init(searchService: SearchServicing) {
        self.searchService = searchService
    }
}
