//
//  SearchViewController+Delegates.swift
//  Jihat
//
//  Created by Peter Bassem on 05/03/2022.
//  Copyright © 2022 Jehat. All rights reserved.
//
//

import UIKit

extension SearchViewController: SearchViewProtocol {
    func refreshTableView() {
        _tableView.reloadData()
    }
}
