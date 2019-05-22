//
//  BookDetailPresenter.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

protocol BookDetailPresenting: class {
    var view: BookDetailViewable? { get set }
    func didLoad()
}

final class BookDetailPresenter: BookDetailPresenting {
    weak var view: BookDetailViewable?
    private let book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func didLoad() {
        updateHeader()
        updateAuthors()
    }
    
    // MARK:- UI Updating
    
    private func updateHeader() {
        let imageUrl: URL? = {
            if let id = book.coverId {
                return URL(string: "http://covers.openlibrary.org/b/ID/\(id)-M.jpg")
            } else {
                return nil
            }
        }()
        
        let displayItem = BookDetailHeaderDisplayItem(imageUrl: imageUrl, title: book.title ?? "Unknown")
        view?.updateHeader(displayItem: displayItem)
    }
    
    private func updateAuthors() {
        let title = book.authorNames.count <= 1 ? "Author" : "Authors"
        let authorsDisplayText: String = {
            if book.authorNames.isEmpty {
                return "Unknown"
            } else {
                return book.authorNames.joined(separator: ", ")
            }
        }()
        let displayItem = BookDetailAuthorsDisplayItem(title: title, authors: authorsDisplayText)
        view?.updateAuthors(displayItem: displayItem)
    }
}
