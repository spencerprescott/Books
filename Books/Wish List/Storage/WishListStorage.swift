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
    var numberOfBooksInWishList: Int { get }
    func book(at index: Int) -> Book
    func refreshBooks() -> Result<Void, Error>
}

protocol WishListStorageDelegate: class {
    func wishListStorageWillChangeContent(_ storage: WishListStoring)
    func wishListStorageDidChangeContent(_ storage: WishListStoring)
    func wishListStorage(_ storage: WishListStoring, itemDidChange itemUpdate: ItemUpdate)
}

final class WishListStorage: NSObject, WishListStoring {
    var numberOfBooksInWishList: Int {
        return 0
    }
    
    func book(at index: Int) -> Book {
        return Book(coverId: nil, editionCount: nil, title: nil, authorNames: [], firstPublishYear: nil, key: nil, publishers: [])
    }
    
    weak var delegate: WishListStorageDelegate?
    
    private let frc: NSFetchedResultsController<BookModel>
    
    init(dataStore: DataStoring) {
        let request: NSFetchRequest<BookModel> = BookModel.fetchRequest()
        // TODO: Sort by added at date
        request.sortDescriptors = [NSSortDescriptor(key: "coverId", ascending: true)]
        self.frc = NSFetchedResultsController(fetchRequest: request,
                                              managedObjectContext: dataStore.viewContext,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)
        super.init()
        self.frc.delegate = self
    }
    
    func refreshBooks() -> Result<Void, Error> {
        do {
            try frc.performFetch()
            return .success(result: ())
        } catch {
            return .failure(error: error)
        }
    }
}

extension WishListStorage: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.wishListStorageWillChangeContent(self)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let _ = anObject as? BookModel else { return }
        let itemUpdate = ItemUpdate(type: type, indexPath: indexPath, newIndexPath: newIndexPath)
        delegate?.wishListStorage(self, itemDidChange: itemUpdate)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.wishListStorageDidChangeContent(self)
    }
}
