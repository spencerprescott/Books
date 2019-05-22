//
//  BookDetailStorage.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
import CoreData

protocol BookDetailStoring: class {
    func toggleWishListStatus(of book: Book)
}

final class BookDetailStorage: BookDetailStoring {
    private let dataStore: DataStoring
    
    init(dataStore: DataStoring) {
        self.dataStore = dataStore
    }
    
    func toggleWishListStatus(of book: Book) {
        dataStore.write(handler: { [weak self] context in
            guard let self = self else { return }
            self.toggleWishListStatus(of: book, context: context)
        }, saveCompletion: nil)
    }
    
    private func toggleWishListStatus(of book: Book, context: NSManagedObjectContext) {
        
    }
}
