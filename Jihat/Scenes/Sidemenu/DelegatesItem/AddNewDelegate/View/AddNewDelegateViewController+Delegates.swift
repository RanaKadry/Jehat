//
//  AddNewDelegateViewController+Delegates.swift
//  Jihat
//
//  Created Ahmed Barghash on 02/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension AddNewDelegateViewController: AddNewDelegateViewProtocol {
    
    func set(title: String) {
        _appNavigationBar.localizedTitle = title
    }
    
    func set(englishName: String) {
        _englishNameTextField.text = englishName
    }
    
    func set(arabicName: String) {
        _arabicNameTextField.text = arabicName
    }
    
    func set(phone: String) {
        _phoneTextField.set(phoneNumber: phone)
    }
    
    func set(email: String) {
        _emailTextField.text = email
    }
    
    func enableSaveButton() {
        _saveButton.configureButton(true)
    }
    
    func disableSaveButton() {
        _saveButton.configureButton(false)
    }
    
    func startLoadingOnSaveButton() {
        _saveButton.startAnimation()
    }
    
    func stopLoadingOnSaveButton() {
        _saveButton.stopAnimation()
    }
    
}
