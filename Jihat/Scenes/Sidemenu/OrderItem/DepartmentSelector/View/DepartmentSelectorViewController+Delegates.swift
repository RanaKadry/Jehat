//
//  DepartmentSelectorViewController+Delegates.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

extension DepartmentSelectorViewController: DepartmentSelectorViewProtocol {
    
    func refreshTableView() {
        _tableView.reloadData()
    }
}
