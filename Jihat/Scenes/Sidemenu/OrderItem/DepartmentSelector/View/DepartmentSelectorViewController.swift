//
//  DepartmentSelectorViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

final class DepartmentSelectorViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBarTextField: UITextField! {
        didSet { searchBarTextField.addTarget(self, action: #selector(searchBarTextDidChange(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Variables
    var presenter: DepartmentSelectorPresenterProtocol!
    
    private var tableViewDataSourceDelegate: TableView<DirectedEntityItemTableViewCell>!
    var _tableView: UITableView {
        return tableView
    }

    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        setupTableView()
        setupDismissBarButtonItem()
    }
}

// MARK: - Helpers
extension DepartmentSelectorViewController {
    
    func setupTableView() {
        tableView.registerCell(cell: DirectedEntityItemTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
    }
    
    private func setupDismissBarButtonItem() {
        navigationController?.navigationBar.prefersLargeTitles = false
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.isHidden = true
        } else {
            navigationController?.navigationBar.isHidden = false
            let dismissBarButtonItem = UIBarButtonItem(title: "cancel".localized(), style: .plain, target: self, action: #selector(dismissBarButtonItemDidPressed(_:)))
            navigationItem.rightBarButtonItem = dismissBarButtonItem
        }
    }
}

// MARK: - Selectors
extension DepartmentSelectorViewController {
    
    @objc
    private func searchBarTextDidChange(_ sender: UITextField) {
        guard let searchText = searchBarTextField.text else { return }
        presenter.updateIsSearching(searchText != "")
        presenter.searchItems(withSearchText: searchText)
    }
    
    @objc
    private func dismissBarButtonItemDidPressed(_ sender: UIBarButtonItem) {
        presenter.performDismissButtonPressed()
    }
}

// MARK: - UITableViewDataSource
extension DepartmentSelectorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.departmentsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(at: indexPath) as DirectedEntityItemTableViewCell
        presenter.configureTableViewCell(cell, atIndex: indexPath.item)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DepartmentSelectorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectDepartmentItem(atIndex: indexPath.item)
    }
}
