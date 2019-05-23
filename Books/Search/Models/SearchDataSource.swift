//
//  SearchDataSource.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

final class SearchDataSource: NSObject {
    static let empty = SearchDataSource(books: [])
    
    private let items: [BookSearchDisplayItem]
    
    init(books: [Book]) {
        
        // Maps Book to BookSearchDisplayItem
        func displayItem(from book: Book) -> BookSearchDisplayItem {
            let imageUrl: URL? = {
                if let id = book.coverId {
                    return URL(string: "\(Constants.Api.assetUrl)/\(id)-S.jpg")
                }
                return nil
            }()
            return BookSearchDisplayItem(imageUrl: imageUrl,
                                         title: book.title ?? "Unknown")
        }
        
        self.items = books.map(displayItem)
        super.init()
    }
}

extension SearchDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeue(BookSearchResultTableViewCell.self, for: indexPath)
        cell.configure(displayItem: item)
        return cell
    }
}
