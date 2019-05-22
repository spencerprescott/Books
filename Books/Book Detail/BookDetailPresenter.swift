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
    func didTapWishListButton()
}

final class BookDetailPresenter: BookDetailPresenting {
    weak var view: BookDetailViewable?
    private let book: Book
    private let storage: BookDetailStoring
    
    init(book: Book, storage: BookDetailStoring) {
        self.book = book
        self.storage = storage
    }
    
    func didLoad() {
        updateHeader()
        updateAuthors()
        updatePublishers()
    }
    
    func didTapWishListButton() {
        storage.toggleWishListStatus(of: book)
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
        let displayItem = BookDetailTitleDescriptionDisplayItem(title: title, description: authorsDisplayText)
        view?.updateAuthors(displayItem: displayItem)
    }
    
    private func updatePublishers() {
        let title = book.publishers.count <= 1 ? "Publisher" : "Publishers"
        let publishersDisplayText: String = {
            if book.publishers.isEmpty {
                return "Unknown"
            } else {
                return book.publishers.joined(separator: ", ")
            }
        }()
        let displayItem = BookDetailTitleDescriptionDisplayItem(title: title, description: publishersDisplayText)
        view?.updatePublishers(displayItem: displayItem)
    }
}
