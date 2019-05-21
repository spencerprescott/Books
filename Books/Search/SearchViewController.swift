//
//  SearchViewController.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

protocol SearchViewable: class {
    
}

final class SearchViewController: ViewController, SearchViewable {
    private let presenter: SearchPresentable
    
    init(presenter: SearchPresentable) {
        self.presenter = presenter
        super.init()
        self.presenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
