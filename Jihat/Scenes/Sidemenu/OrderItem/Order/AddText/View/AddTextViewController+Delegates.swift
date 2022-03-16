//
//  AddTextViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 10/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension AddTextViewController: AddTextViewProtocol {
    
    func showSaveButton() {
        _saveButton.animate(hidden: false)
    }
    
    func hideSaveButton() {
        _saveButton.animate(hidden: true)
    }
}
