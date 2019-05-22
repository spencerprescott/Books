//
//  Viewable.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

/// Determines how a flow should be displayed
enum DisplayStyle {
    case push
    case present
}

protocol Viewable: class {
    func viewFlow(_ flow: Flow, displayStyle: DisplayStyle)
}

extension Viewable where Self: UIViewController {
    func viewFlow(_ flow: Flow, displayStyle: DisplayStyle) {
        switch displayStyle {
        case .push:
            navigationController?.pushViewController(flow.viewController, animated: true)
        case .present:
            present(flow.viewController, animated: true, completion: nil)
        }
    }
}
