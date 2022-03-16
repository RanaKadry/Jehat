//
//  OrderDetailsViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 29/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension OrderDetailsViewController: OrderDetailsViewProtocol {
    
    func updateAppBarBottomView(atIndex index: Int) {
        _appNavigationBar.selectedIndex = index
        _appNavigationBar.itemSelected()
    }
    
    func refreshAppBarCollectionView() {
        setupAppNavigationBarCollectionView()
        _appNavigationBar.itemsCount = presenter.itemsCount
        _appNavigationBar.itemsCountUpdated()
    }
    
    func refreshView() {
        presenter.didSelectNavigationBarCellItem(atIndex: 0)
    }
    
    func scrollToBottom() {
        
    }
}
