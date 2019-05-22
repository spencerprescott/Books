//
//  BookDetailFlow.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class BookDetailFlow: Flow {
    var viewController: UIViewController {
        return BookDetailViewController(presenter: presenter)
    }
    
    private let presenter: BookDetailPresenting
    
    init(presenter: BookDetailPresenting) {
        self.presenter = presenter
    }
}
