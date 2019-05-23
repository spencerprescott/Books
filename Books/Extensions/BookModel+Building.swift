//
//  BookModel+Building.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation
import CoreData

extension BookModel {
    convenience init?(context: NSManagedObjectContext, book: Book) {
        // Key is required to save the book
        guard let key = book.key else { return nil }
        let publishers: [PublisherModel] = book.publishers.compactMap { name in
            let publisher = PublisherModel(context: context)
            publisher.name = name
            return publisher
        }
        let authors: [AuthorModel] = book.authorNames.compactMap { name in
            let author = AuthorModel(context: context)
            author.name = name
            return author
        }
        self.init(context: context)
        self.publishers = NSSet(array: publishers)
        self.authors = NSSet(array: authors)
        self.coverId = Int64(book.coverId ?? 0)
        self.editionCount = Int64(book.editionCount ?? 0)
        self.firstPublishYear = Int64(book.firstPublishYear ?? 0)
        self.key = key
        self.title = book.title
        // Use current date
        self.dateAdded = Date()
    }
}
