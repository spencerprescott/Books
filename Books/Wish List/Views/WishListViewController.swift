//
//  WishListViewController.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

protocol WishListViewable: Viewable {
    func wishListWillUpdate()
    func wishListUpdated(itemUpdate: ItemUpdate)
    func wishListDidFinishUpdating()
    func didLoadItems(dataSource: WishListDataSource)
}

final class WishListViewController: ViewController, WishListViewable {
    private lazy var tableView: UITableView = {
        let v = UITableView(frame: .zero, style: .plain)
        v.register([WishListItemTableViewCell.self])
        v.delegate = self
        v.estimatedRowHeight = 100
        v.rowHeight = UITableViewAutomaticDimension
        // Remove separators for empty cells
        v.tableFooterView = UIView()
        return v
    }()
    
    private let presenter: WishListPresenting
    private var dataSource: WishListDataSource? {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }
    
    init(presenter: WishListPresenting) {
        self.presenter = presenter
        super.init()
        self.presenter.view = self
        self.title = "Wish List"
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        presenter.didLoad()
    }
    
    // MARK:- WishListViewable
    
    func wishListWillUpdate() {
        tableView.beginUpdates()
    }
    
    func wishListUpdated(itemUpdate: ItemUpdate) {
        switch itemUpdate {
        case .insert(let indexPath):
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .delete(let indexPath):
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move(let fromIndexPath, let toIndexPath):
            tableView.moveRow(at: fromIndexPath, to: toIndexPath)
        case .update(let indexPath):
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .invalid:
            break
        }
    }
    
    func wishListDidFinishUpdating() {
        tableView.endUpdates()
    }
    
    func didLoadItems(dataSource: WishListDataSource) {
        self.dataSource = dataSource
    }
}

extension WishListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath)
    }
}
