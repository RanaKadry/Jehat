//
//  PhoneVerificationViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 18/09/2021.
//

import UIKit

final class PhoneVerificationViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var otpCodeTextField: OneTimeCodeTextField! {
        didSet { configureOTPCodeTextField() }
    }
    @IBOutlet private weak var submitButton: SpinnerButton!
    
    // MARK: - Variables
    var presenter: PhoneVerificationPresenterProtocol!
    
    var _otpCodeTextField: OneTimeCodeTextField {
        return otpCodeTextField
    }
    var _submitButton: SpinnerButton {
        return submitButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UITextField.appearance().tintColor = .clear
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        presenter.viewDidLoad()
        setupAppNavigationBar()
        presenter.performValidation(isValidCode: otpCodeTextField.isValid)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        otpCodeTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UITextField.appearance().tintColor = DesignSystem.Colors.primaryBorderColor.color
    }
}

// MARK: - Helpers
extension PhoneVerificationViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
    
    private func configureOTPCodeTextField() {
        otpCodeTextField.digitFont = DesignSystem.Typography.imageSize.font
        otpCodeTextField.tintColor = .clear
        otpCodeTextField.otpDelegate = self
    }
}

// MARK: - Selectors
extension PhoneVerificationViewController {
    
    @IBAction
    private func resendVerificationCodeButtonDidPressed(_ sender: AlignableButton) {
        presenter.performResendActivationCode()
    }
    
    @IBAction
    private func submitButtonDidPressed(_ sender: UIButton) {
        presenter.performSubmit(withCode: otpCodeTextField.text)
    }
}

// MARK: - OneTimeCodeTextFieldDelegate
extension PhoneVerificationViewController: OneTimeCodeTextFieldDelegate {
    
    func isValidCode(isValid valid: Bool) {
        presenter.performValidation(isValidCode: valid)
    }
}
