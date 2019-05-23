//
//  BookDetailViewController.swift
//  Books
//
//  Created by Spencer Prescott on 5/21/19.
//  Copyright © 2019 Spencer Prescott. All rights reserved.
//

import UIKit

protocol BookDetailViewable: Viewable {
    func updateHeader(displayItem: BookDetailHeaderDisplayItem)
    func updateAuthors(displayItem: BookDetailTitleDescriptionDisplayItem)
    func updatePublishers(displayItem: BookDetailTitleDescriptionDisplayItem)
    func updateWishListButton(title: String)
    func updateMoreInfo(displayItem: BookDetailMoreInfoDisplayItem)
}

final class BookDetailViewController: ViewController, BookDetailViewable {
    private lazy var stackView: UIStackView = {
        let v = UIStackView(frame: .zero)
        v.axis = .vertical
        return v
    }()
    private lazy var scrollView = UIScrollView(backgroundColor: .groupTableViewBackground)
    private lazy var headerView = BookDetailHeaderView()
    private lazy var authorsView = BookDetailTitleDescriptionView()
    private lazy var publishersView = BookDetailTitleDescriptionView()
    private lazy var moreInfoView = BookDetailMoreInfoView()
    private lazy var addToWishListButton: Button = {
        let b = Button(style: .filled)
        b.addTarget(self, action: #selector(addToWishListButtonTapped), for: .touchUpInside)
        return b
    }()
    
    private let presenter: BookDetailPresenting
    
    init(presenter: BookDetailPresenting) {
        self.presenter = presenter
        super.init()
        self.presenter.view = self
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let buttonContainerView = ButtonContainerView(buttons: [addToWishListButton], axis: .vertical)
        view.addSubview(buttonContainerView)
        buttonContainerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottomMargin)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(buttonContainerView.snp.top)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(authorsView)
        stackView.addSeparatorView()
        stackView.addArrangedSubview(publishersView)
        stackView.addSeparatorView()
        stackView.addArrangedSubview(moreInfoView)
        
        // Trigger UI Updates
        presenter.didLoad()
    }
    
    // MARK:- Actions
    
    @objc private func addToWishListButtonTapped() {
        presenter.didTapWishListButton()
    }
    
    // MARK:- BookDetailViewable
    
    func updateHeader(displayItem: BookDetailHeaderDisplayItem) {
        headerView.configure(displayItem: displayItem)
    }
    
    func updateAuthors(displayItem: BookDetailTitleDescriptionDisplayItem) {
        authorsView.configure(displayItem: displayItem)
    }
    
    func updatePublishers(displayItem: BookDetailTitleDescriptionDisplayItem) {
        publishersView.configure(displayItem: displayItem)
    }
    
    func updateWishListButton(title: String) {
        addToWishListButton.setTitle(title, for: .normal)
    }
    
    func updateMoreInfo(displayItem: BookDetailMoreInfoDisplayItem) {
        moreInfoView.configure(displayItem: displayItem)
    }
}
