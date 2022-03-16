//
//  DoubleActionAlertViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 23/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension DoubleActionAlertViewController: DoubleActionAlertViewProtocol {
    
    func set(alertImage: String) {
        _alertImageView.image = alertImage.toImage()
    }
    
    func set(alertTitle: String) {
        _alertTitleLabel.text = alertTitle
    }
    
    func set(alertMessage: String) {
        _alertMessageLabel.text = alertMessage
    }
    
    func set(alertPrimaryActionTitle: String) {
        _alertPrimaryActionButton.setTitle(alertPrimaryActionTitle, for: .normal)
    }
    
    func set(alertPrimaryActionTitleColor: String?) {
        _alertPrimaryActionButton.setTitleColor(alertPrimaryActionTitleColor?.toColor(), for: .normal)
    }
    
    func set(alertPrimaryActionBackgroundColor: String?) {
        _alertPrimaryActionButton.backgroundColor = alertPrimaryActionBackgroundColor?.toColor()
    }
    
    func set(alertSecondaryActionTitle: String) {
        _alertSecondaryActionButton.setTitle(alertSecondaryActionTitle, for: .normal)
    }
    
    func set(alertSecondaryActionTitleColor: String?) {
        _alertSecondaryActionButton.setTitleColor(alertSecondaryActionTitleColor?.toColor(), for: .normal)
    }
    
    func set(alertSecondaryActionBackgroundColor: String?) {
        _alertSecondaryActionButton.backgroundColor = alertSecondaryActionBackgroundColor?.toColor()
    }
}
