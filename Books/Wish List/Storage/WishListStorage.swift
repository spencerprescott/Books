//
//  WishListStorage.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
import CoreData

protocol WishListStoring: class {
    var delegate: WishListStorageDelegate? { get set }
    var numberOfItemsInWishList: Int { get }
    func item(at indexPath: IndexPath) -> WishListItem
    func loadItems() -> Result<Void, Error>
}

protocol WishListStorageDelegate: class {
    func wishListStorageWillChangeContent(_ storage: WishListStoring)
    func wishListStorageDidChangeContent(_ storage: WishListStoring)
    func wishListStorage(_ storage: WishListStoring, itemDidChange itemUpdate: ItemUpdate)
}

final class WishListStorage: NSObject, WishListStoring {
    var numberOfItemsInWishList: Int {
        return frc.fetchedObjects?.count ?? 0
    }
  
    weak var delegate: WishListStorageDelegate?
    
    private let frc: NSFetchedResultsController<BookModel>
    
    init(dataStore: DataStoring) {
        let request: NSFetchRequest<BookModel> = BookModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
        self.frc = NSFetchedResultsController(fetchRequest: request,
                                              managedObjectContext: dataStore.viewContext,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)
        super.init()
        self.frc.delegate = self
    }
    
    func loadItems() -> Result<Void, Error> {
        do {
            try frc.performFetch()
            return .success(result: ())
        } catch {
            return .failure(error: error)
        }
    }
    
    func item(at indexPath: IndexPath) -> WishListItem {
        let bookModel = frc.object(at: indexPath)
        let book = Book(model: bookModel)
        return WishListItem(book: book, dateAdded: bookModel.dateAdded)
    }
}

extension WishListStorage: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.wishListStorageWillChangeContent(self)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard anObject is BookModel else { return }
        let itemUpdate = ItemUpdate(type: type, indexPath: indexPath, newIndexPath: newIndexPath)
        delegate?.wishListStorage(self, itemDidChange: itemUpdate)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.wishListStorageDidChangeContent(self)
    }
}
