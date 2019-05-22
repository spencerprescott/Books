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
}

final class WishListViewController: ViewController, WishListViewable {
    private lazy var tableView: UITableView = {
        let v = UITableView(frame: .zero, style: .plain)
        return v
    }()
    
    private let presenter: WishListPresenting
    
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
}
