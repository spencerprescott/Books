//
//  ItemUpdate.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
import CoreData

enum ItemUpdate {
    case insert(indexPath: IndexPath)
    case delete(indexPath: IndexPath)
    case move(fromIndexPath: IndexPath, toIndexPath: IndexPath)
    case update(indexPath: IndexPath)
    case invalid
    
    init(type: NSFetchedResultsChangeType, indexPath: IndexPath?, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                self = .insert(indexPath: newIndexPath)
                return
            }
        case .delete:
            if let indexPath = indexPath {
                self = .delete(indexPath: indexPath)
                return
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                self = .move(fromIndexPath: indexPath, toIndexPath: newIndexPath)
                return
            }
        case .update:
            if let indexPath = indexPath {
                self = .update(indexPath: indexPath)
                return
            }
        }
        self = .invalid
    }
}
