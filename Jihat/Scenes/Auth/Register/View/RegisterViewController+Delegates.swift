//
//  RegisterViewController+Delegates.swift
//  Jihat
//
//  Created Peter Bassem on 17/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension RegisterViewController: RegisterViewProtocol {
    
    func refreshAppBarCollectionView() {
        setupAppNavigationBarCollectionView()
        _appNavigationBar.itemsCount = presenter.itemsCount
        _appNavigationBar.itemsCountUpdated()
    }
    
    func hideCountry() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?._selectCountryStackViewTop.constant = 0
            self?._selectCountryStackViewHeight.constant = 0
            self?._countryTextFieldTop.constant = 0
            self?._countryTextFieldHeight.constant = 0
        } completion: { [weak self] _ in
            self?._selectCountryStackView.isHidden = true
            self?._countryTextField.isHidden = true
        }
    }
    
    func showCountry() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?._selectCountryStackViewTop.constant = 22
            self?._selectCountryStackViewHeight.constant = 30
            self?._countryTextFieldTop.constant = 11
            self?._countryTextFieldHeight.constant = 48
        } completion: { [weak self] _ in
            self?._selectCountryStackView.isHidden = false
            self?._countryTextField.isHidden = false
        }
    }
    
    func hidePhone() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?._mobilePhoneStackViewTop.constant = 0
            self?._mobilePhoneStackHeight.constant = 0
            self?._mobilePhoneTextFieldTop.constant = 0
            self?._mobilePhoneTextFieldHeight.constant = 0
        } completion: { [weak self] _ in
            self?._mobilePhoneStackView.isHidden = true
            self?._mobilePhoneTextField.isHidden = true
        }
    }
    
    func showPhone() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?._mobilePhoneStackViewTop.constant = 22
            self?._mobilePhoneStackHeight.constant = 30
            self?._mobilePhoneTextFieldTop.constant = 11
            self?._mobilePhoneTextFieldHeight.constant = 48
        } completion: { [weak self] _ in
            self?._mobilePhoneStackView.isHidden = false
            self?._mobilePhoneTextField.isHidden = false
        }
    }
    
    func refreshCountriesPickerView() {
        _countriesPickerView.reloadAllComponents()
    }
    
    func displaySelectedGender(_ gender: String) {
        _genderTextField.text = gender
    }
    
    func displaySelectedContry(_ country: String) {
        _countryTextField.text = country
        presenter.performValidation(arabicFullname: _arabicFullnameTextField.text, englishFullname: _englishFullnameTextField.text, identity: _identityTextField.text, password: _passwordTextField.text, mobileValid: _mobilePhoneTextField.isPhoneValid, email: _emailTextField.text)
    }
    
    func enableCreateNewAccountButton() {
        _createAccountButton.configureButton(true)
    }
    
    func disableCreateNewAccountButton() {
        _createAccountButton.configureButton(false)
    }
    
    func startLoadingOnCreateNewAccountButton() {
        _createAccountButton.startAnimation()
    }
    
    func stopLoadingOnCreateNewAccountButton() {
        _createAccountButton.stopAnimation()
    }
}
