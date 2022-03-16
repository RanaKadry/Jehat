//
//  ForgetPasswordViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 26/10/2021.
//

import UIKit

final class ForgetPasswordViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet { emailTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var resetPasswordButton: SpinnerButton!
    
    // MARK: - Variables
    var presenter: ForgetPasswordPresenterProtocol!
    
    var _emailTextField: UITextField {
        return emailTextField
    }
    var _resetPasswordButton: SpinnerButton {
        return resetPasswordButton
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        setupAppNavigationBar()
        presenter.performValidation(emailTextField.text)
    }
}

// MARK: - Helpers
extension ForgetPasswordViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
}

// MARK: - Selectors
extension ForgetPasswordViewController {
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.performValidation(emailTextField.text)
    }
    
    @IBAction
    private func resetPasswordButtonDidPressed(_ sender: SpinnerButton) {
        view.endEditing(true)
        presenter.performResetPassword(email: emailTextField.text)
    }
}
