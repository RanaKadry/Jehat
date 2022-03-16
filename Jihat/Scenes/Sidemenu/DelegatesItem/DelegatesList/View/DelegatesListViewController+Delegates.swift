//
//  DelegatesListViewController+Delegates.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension DelegatesListViewController: DelegatesListViewProtocol {
    
    func refreshCollectionView() {
        setupCollectionView()
    }
    
    func showEmptyDelegates() {
        _collectionView.reloadData()
        let height = UIScreen.main.bounds.height  - (_appNavigationBar.bounds.height)
        _collectionViewHeight.constant = height
        _collectionView.backgroundView = EmptyDelegatesView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
    }
}
