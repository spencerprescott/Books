//
//  WishListPresenter.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import Foundation

protocol WishListPresenting: class {
    var view: WishListViewable? { get set }
    func didLoad()
}

final class WishListPresenter: WishListPresenting {
    weak var view: WishListViewable?
    private let storage: WishListStoring
    
    init(storage: WishListStoring) {
        self.storage = storage
        self.storage.delegate = self
    }
    
    func didLoad() {
        // Load books from core data
        let result = storage.refreshBooks()
        // If fetch fails then show error alert
        if case let .failure(error) = result {
            view?.showError(message: error.localizedDescription)
        }
    }
}

extension WishListPresenter: WishListStorageDelegate {
    func wishListStorageWillChangeContent(_ storage: WishListStoring) {
        view?.wishListWillUpdate()
    }
    
    func wishListStorage(_ storage: WishListStoring, itemDidChange itemUpdate: ItemUpdate) {
        view?.wishListUpdated(itemUpdate: itemUpdate)
    }
    
    func wishListStorageDidChangeContent(_ storage: WishListStoring) {
        view?.wishListDidFinishUpdating()
    }
}
