//
//  DirectedEntityTableViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

final class DirectedEntityTableViewController: BaseTableViewController {
    
    // MARK: - Variables
    var presenter: DirectedEntityPresenterProtocol!
    private var tableViewDataSourceDelegate: TableView<DirectedEntityItemTableViewCell>!
    private var searchController: UISearchController!
    private var searchBarDelegate: SearchBarDelegate!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        setupTableView()
        setupDismissBarButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSearchBar()
    }
}

// MARK: - Helpers
extension DirectedEntityTableViewController {
    
    func setupTableView() {
//        tableViewDataSourceDelegate = TableView(itemsCount: presenter.departmentsCount, rowConfigurator: { [weak self] cell, row in
//            self?.presenter.configureTableViewCell(cell, atIndex: row)
//        }, rowSelector: { [weak self] row in
//            self?.searchController.dismiss(animated: true)
//            self?.parent?.dismiss(animated: true)
//            self?.presenter.didSelectDepartmentItem(atIndex: row)
//        }, rowHeight: UITableView.automaticDimension)
        tableView.registerCell(cell: DirectedEntityItemTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.placeholder = "search".localized()
        let textFieldInsideUISearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.backgroundColor = DesignSystem.Colors.background3Color.color
        textFieldInsideUISearchBar?.cornerRadius = 4
        textFieldInsideUISearchBar?.borderWidth = 0.5
        textFieldInsideUISearchBar?.borderColor = DesignSystem.Colors.text4Color.color
        textFieldInsideUISearchBar?.font = DesignSystem.Typography.paragraphSmall.font
        textFieldInsideUISearchBar?.textColor = DesignSystem.Colors.text3Color.color
        textFieldInsideUISearchBar?.clearButtonMode = .whileEditing
        let searchIconImageView = textFieldInsideUISearchBar?.leftView as? UIImageView
        searchIconImageView?.image = searchIconImageView?.image?.withRenderingMode(.alwaysTemplate)
        searchIconImageView?.tintColor = DesignSystem.Colors.text3Color.color
        searchBarDelegate = SearchBarDelegate(isSearching: { [weak self] searching in
            self?.presenter.updateIsSearching(searching)
        }, searchText: { [weak self] searchText in
//            self?.
        })
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.delegate = searchBarDelegate
//        searchController.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupDismissBarButtonItem() {
        if #available(iOS 13.0, *) { } else {
            let dismissBarButtonItem = UIBarButtonItem(title: "cancel".localized(), style: .plain, target: self, action: #selector(dismissBarButtonItemDidPressed(_:)))
            navigationItem.rightBarButtonItem = dismissBarButtonItem
        }
    }
}

// MARK: - UITableViewDataSource
extension DirectedEntityTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.departmentsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(at: indexPath) as DirectedEntityItemTableViewCell
        presenter.configureTableViewCell(cell, atIndex: indexPath.item)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DirectedEntityTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.isActive = false
        searchController.dismiss(animated: true)
        
        presenter.didSelectDepartmentItem(atIndex: indexPath.item)
    }
}

// MARK: - Selectors
extension DirectedEntityTableViewController {
    
    @objc
    private func dismissBarButtonItemDidPressed(_ sender: UIBarButtonItem) {
        print("dismiss")
    }
}

extension DirectedEntityTableViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func willDismissSearchController(_ searchController: UISearchController) {
        print("Will dimiss search controller")
//        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.searchItems(withSearchText: searchText)
    }
}
