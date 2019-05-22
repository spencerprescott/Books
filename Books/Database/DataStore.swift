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
    func write(handler: @escaping (NSManagedObjectContext) -> Result<Void, Error>, saveCompletion: ((Result<Void, Error>) -> Void)?)
    /// Save all changes
    func saveContext()
}

extension DataStoring {
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func write(handler: @escaping (NSManagedObjectContext) -> Result<Void, Error>, saveCompletion: ((Result<Void, Error>) -> Void)?) {
        persistentContainer.performBackgroundTask { [weak self] context in
            guard let self = self else { return }
            let result = handler(context)
            switch result {
            case .success:
                do {
                    try context.save()
                    self.notifySaveCompletion(result: .success(result: ()),
                                              saveCompletion: saveCompletion)
                } catch {
                    self.notifySaveCompletion(result: .failure(error: error),
                                              saveCompletion: saveCompletion)
                }
            case .failure(let error):
                self.notifySaveCompletion(result: .failure(error: error),
                                          saveCompletion: saveCompletion)
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
    
    private func notifySaveCompletion(result: Result<Void, Error>, saveCompletion: ((Result<Void, Error>) -> Void)?) {
        DispatchQueue.main.async {
            saveCompletion?(result)
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
