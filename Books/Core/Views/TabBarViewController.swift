//
//  TabBarViewController.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    private let flows: [Flow]
    
    init(flows: [Flow]) {
        self.flows = flows
        super.init(nibName: nil, bundle: nil)
        setViewControllers(flows.map { $0.viewController }, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
