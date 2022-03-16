//
//  UserMeetingDetailsViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 05/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

final class UserMeetingDetailsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var childrenViewControllerContainerView: UIView!
    
    // MARK: - Variables
	var presenter: UserMeetingDetailsPresenterProtocol!
    var collectionViewDataSetup: CollectionView<AppNavigationItemCollectionViewCell>!
    
    var _appNavigationBar: AppNavigationBar {
        return appNavigationBar
    }
    var _childrenViewControllerContainerView: UIView {
        return childrenViewControllerContainerView
    }

    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        setupAppNavigationBar()
    }
}

// MARK: - Helpers
extension UserMeetingDetailsViewController {
    
    private func setupAppNavigationBar() {
        
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
    
    func setupAppNavigationBarCollectionView() {
        collectionViewDataSetup = CollectionView(itemsCount: presenter.itemsCount, itemConfigurator: { [weak self] cell, index in
            self?.presenter.configureNavigationBarCellItem(cell, atIndex: index)
        }, itemSelector: { [weak self] index in
            self?.presenter.didSelectNavigationBarCellItem(atIndex: index)
        }, itemSize: .init(width: UIScreen.main.bounds.width / CGFloat(presenter.itemsCount), height: appNavigationBar._collectionView.frame.size.height), itemSpacing: 0)
        appNavigationBar._collectionView.dataSource = collectionViewDataSetup
        appNavigationBar._collectionView.delegate = collectionViewDataSetup
        appNavigationBar._collectionView.registerCell(cell: AppNavigationItemCollectionViewCell.self)
        appNavigationBar._collectionView.showsHorizontalScrollIndicator = false
        appNavigationBar._collectionView.showsVerticalScrollIndicator = false
        if let layout = appNavigationBar._collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

// MARK: - Selectors
extension UserMeetingDetailsViewController {
    
    
}
