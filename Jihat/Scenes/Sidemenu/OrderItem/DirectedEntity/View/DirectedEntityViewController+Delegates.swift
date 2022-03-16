//
//  DirectedEntityViewController+Delegates.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

extension DirectedEntityTableViewController: DirectedEntityViewProtocol {
    
    func refreshTableView() {
        tableView.reloadData()
    }
}
