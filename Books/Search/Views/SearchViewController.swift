//
//  SearchViewController.swift
//  Books
//
//  Created by Spencer Prescott on 5/20/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchViewable: class {
    func viewBook(detailFlow: Flow)
    func showError(message: String)
    func showSearchResults(dataSource: SearchDataSource)
}

final class SearchViewController: ViewController, SearchViewable {
    private let presenter: SearchPresentable
  
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search Books"
        controller.searchResultsUpdater = self
        return controller
    }()

    private lazy var tableView: UITableView = {
        let v = UITableView(frame: .zero, style: .plain)
        v.estimatedRowHeight = 100
        v.rowHeight = UITableViewAutomaticDimension
        v.delegate = self
        v.register([BookSearchResultTableViewCell.self])
        return v
    }()
    
    private lazy var loadingView = LoadingFooterView()
    
    private var dataSource: SearchDataSource = .empty {
        didSet {
            tableView.dataSource = dataSource
            loadingView.isHidden = dataSource.isEmpty
            tableView.reloadData()
        }
    }
    
    init(presenter: SearchPresentable) {
        self.presenter = presenter
        super.init()
        self.presenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        // Setup Navigation Bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Books"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Setup Loading Footer
        let fittingSize = CGSize(width: view.bounds.width, height: 0)
        let size = loadingView.systemLayoutSizeFitting(fittingSize,
                                                       withHorizontalFittingPriority: .required,
                                                       verticalFittingPriority: .fittingSizeLevel)
        loadingView.frame = CGRect(origin: .zero, size: size)
        tableView.tableFooterView = loadingView
        loadingView.isHidden = dataSource.isEmpty
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
    
    func showSearchResults(dataSource: SearchDataSource) {
        self.dataSource = dataSource
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectBook(at: indexPath.row)
    }
}

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = ceil(scrollView.contentOffset.y + scrollView.frame.size.height)
        
        // Check if we've reached the bottom of the content
        if bottomEdge >= ceil(scrollView.contentSize.height) {
            presenter.loadNextPage()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
        perform(#selector(search), with: nil, afterDelay: 0.5)
    }
    
    @objc private func search() {
        presenter.search(query: searchController.searchBar.text)
    }
}
