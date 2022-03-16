//
//  FilterMeetingViewController+Delegates.swift
//  Jihat
//
//  Created by Peter Bassem on 28/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

extension FilterMeetingViewController: FilterMeetingViewProtocol {
    
    func refreshTableView() {
        setupMeetingFilterItemsTableView()
    }
    
    func enableFilterButton() {
        _filterButton.configureButton(true)
    }
    
    func disableFilterButton() {
        _filterButton.configureButton(false)
    }
}
