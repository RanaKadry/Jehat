//
//  LoginViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 15/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension LoginViewController: LoginViewProtocol {
    
    func setLanguageButtonTitle(_ title: String) {
        _changeLanguageButton.setTitle(title, for: .normal)
    }
    
    func enableLoginButton() {
        _loginButton.configureButton(true)
    }
    
    func disableLoginButton() {
        _loginButton.configureButton(false)
    }
    
    func refreshCollectionView() {
        _sponsersCollectionView.reloadData()
    }
    
    func startLoadingOnLoginButton() {
        _loginButton.startAnimation()
    }
    
    func stopLoadingOnLoginButton() {
        _loginButton.stopAnimation()
    }
}
