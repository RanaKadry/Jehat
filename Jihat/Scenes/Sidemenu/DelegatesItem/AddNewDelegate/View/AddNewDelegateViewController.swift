//
//  AddNewDelegateViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 02/10/2021.
//

import UIKit

class AddNewDelegateViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var arabicNameTextField: UITextField! {
        didSet { arabicNameTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var englishNameTextField: UITextField!{
        didSet { englishNameTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var phoneTextField: PhoneNumberTextField!{
        didSet { phoneTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var emailTextField: UITextField!{
        didSet { emailTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var saveButton: SpinnerButton!
    
    // MARK: - Variables
    var presenter: AddNewDelegatePresenterProtocol!
    
    var _appNavigationBar: AppNavigationBar {
        return appNavigationBar
    }
    var _arabicNameTextField: UITextField {
        return arabicNameTextField
    }
    var _englishNameTextField: UITextField {
        return englishNameTextField
    }
    var _phoneTextField: PhoneNumberTextField {
        return phoneTextField
    }
    var _emailTextField: UITextField {
        return emailTextField
    }
    var _saveButton: SpinnerButton {
        return saveButton
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupAppNavigationBar()
        presenter.performObserveInputs(arabicName: arabicNameTextField.text, englishName: englishNameTextField.text, mobile: phoneTextField.formattedPhone, mobileIsValid: phoneTextField.isPhoneValid, email: emailTextField.text)
        
    }
    
    
}

// MARK: - Helpers
extension AddNewDelegateViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
    
}

// MARK: - Selectors
extension AddNewDelegateViewController {
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.performObserveInputs(arabicName: arabicNameTextField.text, englishName: englishNameTextField.text, mobile: phoneTextField.formattedPhone, mobileIsValid: phoneTextField.isPhoneValid, email: emailTextField.text)
    }
    
    @IBAction
    private func saveButtonDidPressed(_ sender: Any) {
        presenter.performAddDelegate(arabicName: arabicNameTextField.text, englishName: englishNameTextField.text, mobile: phoneTextField.formattedPhone, email: emailTextField.text)
    }
    
}

// MARK: - PhoneNumberTextFieldDelegate
extension AddNewDelegateViewController: PhoneNumberTextFieldDelegate {
    func phoneNumberTextFieldIsValidPhone(_ isValid: Bool) {
        presenter.performObserveInputs(arabicName: arabicNameTextField.text, englishName: englishNameTextField.text, mobile: phoneTextField.formattedPhone, mobileIsValid: isValid, email: emailTextField.text)
    }
    
    func phoneNumberTextFieldDisplayCountriesListViewController() {
        presenter.performShowCountriesList()
    }
}
