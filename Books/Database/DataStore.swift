//
//  DataStore.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
import CoreData

protocol DataStoring: class {
    var persistentContainer: NSPersistentContainer { get }
    /// Context associated with main queue
    var viewContext: NSManagedObjectContext { get }
    /// Executes core data writes on the background queue, calls save handler on main queue
    func write(handler: @escaping (NSManagedObjectContext) -> Void, saveCompletion: ((Result<Void, Error>) -> Void)?)
    /// Save all changes
    func saveContext()
}

extension DataStoring {
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func write(handler: @escaping (NSManagedObjectContext) -> Void, saveCompletion: ((Result<Void, Error>) -> Void)?) {
        persistentContainer.performBackgroundTask { context in
            handler(context)
            var writeError: Error?
            do {
                try context.save()
            } catch {
                writeError = error
                print("Failed to save context: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                if let error = writeError {
                    saveCompletion?(.failure(error: error))
                } else {
                    saveCompletion?(.success(result: ()))
                }
            }
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error saving context \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

final class DataStore: DataStoring {
    static let shared = DataStore()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Books")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Error setting up core data stack \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
}
