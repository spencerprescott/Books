//
//  SearchViewController.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

protocol SearchViewable: class {
    func viewBook(detailFlow: Flow)
    func showError(message: String)
    func showSearchResults(_ displayItems: [BookSearchDisplayItem])
}

final class SearchViewController: ViewController, SearchViewable {
    private let presenter: SearchPresentable
    private var displayItems: [BookSearchDisplayItem] = []

    private lazy var tableView: UITableView = {
        let v = UITableView(frame: .zero, style: .plain)
        v.estimatedRowHeight = 100
        v.rowHeight = UITableViewAutomaticDimension
        v.delegate = self
        // TODO: Move to separate class
        v.dataSource = self
        v.register([BookSearchResultTableViewCell.self])
        return v
    }()
    
    init(presenter: SearchPresentable) {
        self.presenter = presenter
        super.init()
        self.presenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- SearchViewable
    
    func viewBook(detailFlow: Flow) {
        
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "An Error Occurred",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showSearchResults(_ displayItems: [BookSearchDisplayItem]) {
        self.displayItems.append(contentsOf: displayItems)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(BookSearchResultTableViewCell.self, for: indexPath)
        cell.configure(displayItem: displayItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectBook(at: indexPath.row)
    }
}