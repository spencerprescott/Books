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
    private var isBookOnWishList: Bool
    
    init(book: Book, storage: BookDetailStoring) {
        self.book = book
        self.storage = storage
        self.isBookOnWishList = storage.isBookOnWishList(book)
    }
    
    func didLoad() {
        updateHeader()
        updateAuthors()
        updatePublishers()
        updateAddToWishListButton()
        updateMoreInfo()
    }
    
    func didTapWishListButton() {
        storage.toggleWishListStatus(of: book) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.isBookOnWishList.toggle()
                self.updateAddToWishListButton()
            case .failure(let error):
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    // MARK:- UI Updating
    
    private func updateHeader() {
        let imageUrl: URL? = {
            if let id = book.coverId {
                return URL(string: "\(Constants.Api.assetUrl)/\(id)-M.jpg")
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
    
    private func updateAddToWishListButton() {
        let title = isBookOnWishList ? "Remove From Wish List" : "Add To Wish List"
        view?.updateWishListButton(title: title)
    }
    
    private func updateMoreInfo() {
        let publishYear: String = {
            guard let year = book.firstPublishYear else { return "Unknown" }
            return "\(year)"
        }()
        let editionCount: String = {
            guard let count = book.editionCount else { return "Unknown" }
            return "\(count)"
        }()
        let displayItem = BookDetailMoreInfoDisplayItem(publishYear: publishYear, editionCount: editionCount)
        view?.updateMoreInfo(displayItem: displayItem)
    }
}
