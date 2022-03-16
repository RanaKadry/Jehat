//
//  UserMeetingDetailsViewController+Delegates.swift
//  Jihat
//
//  Created by Peter Bassem on 05/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

extension UserMeetingDetailsViewController: UserMeetingDetailsViewProtocol {
    
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
}
