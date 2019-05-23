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
    func didSelectItem(at indexPath: IndexPath)
}

final class WishListPresenter: WishListPresenting {
    weak var view: WishListViewable?
    private let storage: WishListStoring
    private let flowFactory: FlowFactory
    
    init(storage: WishListStoring, flowFactory: FlowFactory) {
        self.storage = storage
        self.flowFactory = flowFactory
        self.storage.delegate = self
    }
    
    func didLoad() {
        do {
            // Load items from core data
            try storage.loadItems()
            let dataSource = WishListDataSource(storage: storage)
            view?.didLoadItems(dataSource: dataSource)
        } catch {
            view?.showError(message: error.localizedDescription)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let item = storage.item(at: indexPath)
        let book = item.book
        let flow = flowFactory.flow(flowType: .detail(book: book))
        view?.viewFlow(flow, displayStyle: .push)
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
