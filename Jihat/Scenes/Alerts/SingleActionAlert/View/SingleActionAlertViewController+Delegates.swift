//
//  SingleActionAlertViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 22/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension SingleActionAlertViewController: SingleActionAlertViewProtocol {
    
    func set(alertImage: String) {
        _alertImageView.image = alertImage.toImage()
    }
    
    func set(alertTitle: String) {
        _alertTitleLabel.text = alertTitle
    }
    
    func set(alertMessage: String) {
        _alertMessageLabel.text = alertMessage
    }
    
    func set(alertActionTitle: String) {
        _alertActionButton.setTitle(alertActionTitle, for: .normal)
    }
    
    func set(alertActionTitleColor: String?) {
        _alertActionButton.setTitleColor(alertActionTitleColor?.toColor(), for: .normal)
    }
    
    func set(alertActionBackgroundColor: String?) {
        _alertActionButton.backgroundColor = alertActionBackgroundColor?.toColor()
    }
}
