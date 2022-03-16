//
//  DocumentsViewController+Delegates.swift
//  Jihat
//
//  Created Ahmed Barghash on 04/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension DocumentsViewController: DocumentsViewProtocol {
    
    func refreshCollectionView() {
        _collectionView.reloadData()
        setupCollectionView()
    }
    
    func showEmptyDocuments() {
        _collectionView.reloadData()
        _collectionView.backgroundView = EmptyDocumentsView(frame: _collectionView.frame)
    }
    
    func showNoSearchResult() {
        _collectionView.reloadData()
        _collectionView.backgroundView = EmptySearchResult(frame: _collectionView.frame)
    }
}
