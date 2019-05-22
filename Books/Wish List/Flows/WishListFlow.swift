//
//  WishListFlow.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class WishListFlow: Flow {
    var viewController: UIViewController {
        let viewController = WishListViewController(presenter: presenter)
        return NavigationController(rootViewController: viewController)
    }
    
    private let presenter: WishListPresenting
    
    init(presenter: WishListPresenting) {
        self.presenter = presenter
    }
}
