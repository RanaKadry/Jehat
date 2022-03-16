//
//  PhoneVerificationViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 18/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension PhoneVerificationViewController: PhoneVerificationViewProtocol {
    
    func clearOTPCodeTextField() {
        _otpCodeTextField.clearTextField()
    }
    
    func enableSubmitButton() {
        _submitButton.configureButton(true)
    }
    
    func disbaleSubmitButton() {
        _submitButton.configureButton(false)
    }
    
    func startLoadingOnSubmitButton() {
        _submitButton.startAnimation()
    }
    
    func stopLoadingOnSubmitButton() {
        _submitButton.stopAnimation()
    }
}
