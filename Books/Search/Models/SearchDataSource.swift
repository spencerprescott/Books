//
//  SearchDataSource.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class SearchDataSource: NSObject {
    static let empty = SearchDataSource(items: [])
    
    /// Returns if the data sources has any items to show
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    private let items: [BookSearchDisplayItem]
    
    init(items: [BookSearchDisplayItem]) {
        self.items = items
        super.init()
    }
}

extension SearchDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(BookSearchResultTableViewCell.self, for: indexPath)
        cell.configure(displayItem: items[indexPath.row])
        return cell
    }
}
