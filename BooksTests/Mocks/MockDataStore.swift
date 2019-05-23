//
//  MockDataStore.swift
//  BooksTests
//
//  Created by Spencer Prescott on 5/23/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
import CoreData
@testable import Books

final class MockDataStore: DataStoring {
    /// Creates in memory data store for testing purposes
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BooksTests")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition(description.type == NSInMemoryStoreType)
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
}
