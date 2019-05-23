//
//  WishListDataSource.swift
//  Books
//
//  Created by Spencer Prescott on 5/22/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class WishListDataSource: NSObject {
    private let storage: WishListStoring
    
    init(storage: WishListStoring) {
        self.storage = storage
        super.init()
    }
    
    private func displayItem(from item: WishListItem) -> WishListDisplayItem {
        let imageUrl: URL? = {
            if let id = item.book.coverId {
                return URL(string: "http://covers.openlibrary.org/b/ID/\(id)-S.jpg")
            }
            return nil
        }()
        let dateAdded: String? = {
            guard let date = item.dateAdded else { return nil }
            return "Added on \(DateFormat.shared.monthDateYear(from: date))"
        }()
        return WishListDisplayItem(title: item.book.title, imageUrl: imageUrl, dateAdded: dateAdded)
    }
}

extension WishListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.numberOfItemsInWishList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = storage.item(at: indexPath)
        let cell = tableView.dequeue(WishListItemTableViewCell.self, for: indexPath)
        cell.configure(displayItem: displayItem(from: item))
        return cell
    }
}
