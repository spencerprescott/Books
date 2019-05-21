//
//  SearchFlow.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

final class SearchFlow: Flow {
    private let presenter: SearchPresentable
    
    var viewController: ViewController {
        return SearchViewController(presenter: presenter)
    }
    
    init(presenter: SearchPresentable) {
        self.presenter = presenter
    }
}
