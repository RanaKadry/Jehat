//
//  ProfileViewController+Delegates.swift
//  Jihat
//
//  Created Ahmed Barghash on 25/09/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension ProfileViewController: ProfileViewProtocol {
    
    func refreshNationalitiesPickerView() {
        setupNationaltyPickerView()
    }
    
    func setResident(_ resident: String?) {
        _residentLabel.text = resident
    }
    
    func setNationality(_ nationality: String?) {
        _nationalityTextField.text = nationality
    }
    
    func selectNationalityInPicker(atIndex index: Int) {
        _nationalityPickerView.selectRow(index, inComponent: 0, animated: false)
    }

    func setArabicName(_ arabicName: String?) {
        _arabicNameTextField.text = arabicName
    }
    
    func setEnglishName(_ englishName: String?) {
        _englishNameTextField.text = englishName
    }
    
    func setGender(_ gender: String?) {
        _genderTextField.text = gender
    }
    
    func setPhoneFlag(_ flag: String?) {
        _mobileTextField.updateCountry(withFlagCode: flag ?? "")
    }
    
    func setPhoneNumber(_ phone: String?) {
        _mobileTextField.set(phoneNumber: phone ?? "")
    }
    
    func setEmail(_ email: String?) {
        _emailTextField.text = email
    }
    
    func setUserId(_ id: String?) {
        _idNumberTextField.text = id
    }
    
    func setUserAddress(_ address: String?) {
        _addressTextField.text = address
    }
    
    func setUserFax(_ fax: String?) {
        _faxTextField.text = fax
    }
    
    func enableEditNationality() {
        _nationalityPickerView.animate(hidden: false)
    }
    
    func disableEditNationality() {
        _nationalityPickerView.animate(hidden: true)
    }
    
    func set(nationality: String) {
        _nationalityTextField.text = nationality
    }
    
    func enableEditArabicNameTextField() {
        _arabicNameTextField.isEnabled = true
        _arabicNameTextField.alpha = 1
    }
    
    func enableEditEnglishNameTextField() {
        _englishNameTextField.isEnabled = true
        _englishNameTextField.alpha = 1
    }
    
    func enableEditGender() {
        _genderPickerView.animate(hidden: false)
    }
    
    func disableEditGender() {
        _genderPickerView.animate(hidden: true)
    }
    
    func setSelectedGender(gender: String) {
        _genderTextField.text = gender
    }
    
    func enableEditMobileTextField() {
        _mobileTextField.isEnabled = true
        _mobileTextField.alpha = 1
    }
    
    func enableEditEmailTextField() {
        _emailTextField.isEnabled = true
        _emailTextField.alpha = 1
    }
    
    func enableEditIdNumberTextField() {
        _idNumberTextField.isEnabled = true
        _idNumberTextField.alpha = 1
    }
    
    func enableEditAddressTextField() {
        _addressTextField.isEnabled = true
        _addressTextField.alpha = 1
    }
    
    func enableEditFaxTextField() {
        _faxTextField.isEnabled = true
        _faxTextField.alpha = 1
    }
    
    func enableSaveChangesButton() {
        _saveChangesButton.configureButton(true)
    }
    
    func disableSaveChangesButton() {
        _saveChangesButton.configureButton(false)
    }
    
    func startLoadingOnSaveChangesButton() {
        _saveChangesButton.startAnimation()
    }
    
    func stopLoadingOnSaveChangesButton() {
        _saveChangesButton.stopAnimation()
    }
}
