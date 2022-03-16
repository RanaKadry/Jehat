//
//  ForgetPasswordViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 26/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension ForgetPasswordViewController: ForgetPasswordViewProtocol {
    
    func enableResetPasswordButton() {
        _resetPasswordButton.configureButton(true)
    }
    
    func disableResetPasswordButton() {
        _resetPasswordButton.configureButton(false)
    }
    
    func startLoadingOnResetPasswordButton() {
        _resetPasswordButton.startAnimation()
    }
    
    func stopLoadingOnResetPasswordButton() {
        _resetPasswordButton.stopAnimation()
    }
}
