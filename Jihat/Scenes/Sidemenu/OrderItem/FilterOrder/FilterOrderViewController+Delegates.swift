//
//  FilterOrderViewController+Delegates.swift
//  Jihat
//
//  Created by Peter Bassem on 27/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

extension FilterOrderViewController: FilterOrderViewProtocol {
    
    func refreshTableView() {
        setupOrderFilterItemsTableView()
    }
    
    func enableFilterButton() {
        _filterButton.configureButton(true)
    }
    
    func disableFilterButton() {
        _filterButton.configureButton(false)
    }
}
