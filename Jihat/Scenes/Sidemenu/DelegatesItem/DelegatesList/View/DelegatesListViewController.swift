//
//  DelegatesListViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 02/10/2021.
//

import UIKit

final class DelegatesListViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var addNewDelegateButton: TitleWithImageButton!
    
    // MARK: - Variables
    var presenter: DelegatesListPresenterProtocol!
    var collectionViewDataSetUp: CollectionView<DelegatesListItemCollectionViewCell>!
    
    var _appNavigationBar: AppNavigationBar {
        return appNavigationBar
    }
    var _collectionViewHeight: NSLayoutConstraint {
        return collectionViewHeight
    }
    var _collectionView: UICollectionView {
        return collectionView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        setupAppNavigationBar()
        setupCollectionView()
    }
}

// MARK: - Helpers
extension DelegatesListViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
    
    func setupCollectionView() {
        collectionViewDataSetUp = CollectionView(itemsCount: presenter.itemsCount, itemConfigurator: { [weak self] (cell, index) in
            cell.index = index
            cell.delegate = self
            self?.presenter.configureCollectionViewCellItem(cell, atIndex: index)
        }, itemSelector: { [weak self] (index) in
            self?.presenter.didSelectCollectionViewCellItem(atIndex: index)
        }, itemSize: CGSize(width: collectionView.frame.size.width, height: 264))
        collectionView.registerCell(cell: DelegatesListItemCollectionViewCell.self)
        collectionView.dataSource = collectionViewDataSetUp
        collectionView.delegate = collectionViewDataSetUp
        updateCollectionViewHeight()
    }
    
    func updateCollectionViewHeight() {
        collectionView.reloadData()
        collectionView.backgroundView = nil
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionViewHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
}

// MARK: - Selectors
extension DelegatesListViewController {
    
    @IBAction
    private func addNewDelegateButtonDidPressed(_ sender: Any) {
        presenter.performAddNewDelegate()
    }
    
}

// MARK: - DelegatesListItemCollectionViewCellDelegate
extension DelegatesListViewController: DelegatesListItemCollectionViewCellDelegate {
    
    func didEditDelegate(atIndex index: Int) {
        presenter.performEditDelegate(atIndex: index)
    }
    
    func didShareDelegate(atIndex index: Int) {
        presenter.performShareDelegate(atIndex: index)
    }
    
    func didDeleteDelegate(atIndex index: Int) {
        presenter.performDeleteDelegate(atIndex: index)
    }
}
