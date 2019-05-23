//
//  WishListStorage.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
import CoreData

protocol BookDetailStoring: class {
    func toggleWishListStatus(of book: Book, completion: @escaping (Result<Void, Error>) -> Void)
    func isBookOnWishList(_ book: Book) -> Bool
}

struct BookDetailStorageError: LocalizedError {
    let errorDescription: String?
}

final class BookDetailStorage: BookDetailStoring {
    private let dataStore: DataStoring
    
    init(dataStore: DataStoring) {
        self.dataStore = dataStore
    }
    
    func isBookOnWishList(_ book: Book) -> Bool {
        guard let key = book.key else { return false }
        let context = dataStore.persistentContainer.viewContext
        let request = fetchRequestForBookModel(key: key)
        do {
            let results = try context.fetch(request)
            return !results.isEmpty
        } catch {
            return false
        }
    }
    
    func toggleWishListStatus(of book: Book, completion: @escaping (Result<Void, Error>) -> Void) {
        dataStore.write(handler: { [weak self] context in
            guard let self = self
                else { return .failure(error: BookDetailStorageError(errorDescription: "Unknown Error")) }
            return self.toggleWishListStatus(of: book, context: context)
            }, saveCompletion: completion)
    }
    
    private func toggleWishListStatus(of book: Book, context: NSManagedObjectContext) -> Result<Void, Error> {
        guard let key = book.key
            else { return .failure(error: BookDetailStorageError(errorDescription: "Book does not have a key. One is required to add it to the wishlist.")) }
        
        do {
            // Build request to find parameterized book
            let request = fetchRequestForBookModel(key: key)
            let results = try context.fetch(request)
            
            // If book exists, we remove it since this is toggling if its on the wishlist
            if let bookModel = results.first as? BookModel {
                context.delete(bookModel)
                return .success(result: ())
            }
                // Otherwise save the book so its on the wishlist
            else {
                guard let _ = BookModel(context: context, book: book)
                    else { return .failure(error: BookDetailStorageError(errorDescription: "Failed to save book")) }
                return .success(result: ())
            }
        } catch {
            return .failure(error: error)
        }
    }
    
    private func fetchRequestForBookModel(key: String) -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = BookModel.fetchRequest()
        request.predicate = NSPredicate(format: "key = %@", key)
        request.fetchLimit = 1
        return request
    }
}
