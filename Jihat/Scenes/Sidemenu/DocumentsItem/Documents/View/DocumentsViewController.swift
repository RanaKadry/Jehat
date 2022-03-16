//
//  DocumentsViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 04/10/2021.
//

import UIKit

final class DocumentsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var searchBar: UISearchBar!{
        didSet { setupSearchBar() }
    }
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var presenter: DocumentsPresenterProtocol!
    
    var _appNavigationBar: AppNavigationBar {
        return appNavigationBar
    }
    var _searchBar: UISearchBar {
        return searchBar
    }
    private var searchBarDelegate: SearchBarDelegate!
    var _collectionView: UICollectionView {
        return collectionView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupAppNavigationBar()
        setupCollectionView()
    }
}

// MARK: - Helpers
extension DocumentsViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
    
    private func setupSearchBar() {
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = true
        searchBar.placeholder = "search_documents".localized()
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
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
            self?.presenter.searchDocuments(withSearchText: searchText)
        })
        searchBar.delegate = searchBarDelegate
    }
    
    func setupCollectionView() {
        collectionView.registerCell(cell: DocumentsItemCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        updateCollectionViewHeight()
    }
    
    func updateCollectionViewHeight() {
        collectionView.reloadData()
        collectionView.backgroundView = nil
    }
}

// MARK: - Selectors
extension DocumentsViewController {
    
    @IBAction
    private func addNewDocumentButtonDidPressed(_ sender: Any) {
        presenter.performAddNewDocument()
    }
}

// MARK: - UICollectionViewDataSource
extension DocumentsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(at: indexPath) as DocumentsItemCollectionViewCell
        cell.index = indexPath.item
        cell.delegate = self
        presenter.configureCollectionViewCellItem(cell, atIndex: indexPath.item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DocumentsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCollectionViewCellItem(atIndex: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DocumentsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.size.width, height: 233)
    }
}

// MARK: - DocumentsItemCollectionViewCellDelegate
extension DocumentsViewController: DocumentsItemCollectionViewCellDelegate {
    
    func didEditDocument(atIndex index: Int) {
        presenter.performEditDocument(atIndex: index)
    }
    
    func didShareDocument(atIndex index: Int) {
        presenter.performShareDocument(atIndex: index)
    }
    
    func didDeleteDocument(atIndex index: Int) {
        presenter.performDeleteDocument(atIndex: index)
    }
}
