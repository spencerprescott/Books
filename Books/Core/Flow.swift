//
//  Flow.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

/// A flow is a feature in the app. It's responsible for building the MVP objects for a feature
protocol Flow {
    /// Root view controller in the flow
    var viewController: ViewController { get }
}

final class EmptyFlow: Flow {
    var viewController: ViewController {
        return ViewController()
    }
}
