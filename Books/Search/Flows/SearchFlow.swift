//
//  SearchFlow.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class SearchFlow: Flow {
    private let presenter: SearchPresentable
    
    var viewController: UIViewController {
        let viewController = SearchViewController(presenter: presenter)
        return NavigationController(rootViewController: viewController)
    }
    
    init(presenter: SearchPresentable) {
        self.presenter = presenter
    }
}
