//
//  AddVoiceNoteViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension AddVoiceNoteViewController: AddVoiceNoteViewProtocol {
    
    func showSaveButton() {
        _saveButton.animate(hidden: false)
    }
    
    func hideSaveButton() {
        _saveButton.animate(hidden: true)
    }
    
    func showLoadingOnSaveButton() {
        _saveButton.startAnimation()
    }
    
    func hideLoadingOnSaveButton() {
        _saveButton.stopAnimation()
    }
    
    func showResetButton() {
        _resetButton.animate(hidden: false)
    }
    
    func hideResetButton() {
        _resetButton.animate(hidden: true)
    }
}
