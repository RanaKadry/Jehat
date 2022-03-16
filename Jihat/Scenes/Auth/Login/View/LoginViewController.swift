//
//  LoginViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 15/09/2021.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var changeLanguageButton: UIButton!
    @IBOutlet private weak var loginAsAgentView: UIView! {
        didSet {
            loginAsAgentView.isUserInteractionEnabled = true
            loginAsAgentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginAsAgentDidPressed(_:))))
        }
    }
    @IBOutlet private weak var usernameTextField: UITextField! {
        didSet { usernameTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var passwordTextField: PasswordTextField! {
        didSet { passwordTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var loginButton: SpinnerButton!
    @IBOutlet private weak var sponsersCollectionView: UICollectionView!
    
    // MARK: - Variables
    var presenter: LoginPresenterProtocol!
    
    var _changeLanguageButton: UIButton {
        return changeLanguageButton
    }
    var _loginButton: SpinnerButton {
        return loginButton
    }
    var _sponsersCollectionView: UICollectionView {
        return sponsersCollectionView
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
//        navigationController?.setNavigationBarHidden(true, animated: false)
        setupChangeLanguageButton()
        presenter.performValidate(withUsername: usernameTextField.text, password: passwordTextField.text)
        setupCollectionView()
    }
}

// MARK: - Helpers
extension LoginViewController {
    
    private func setupChangeLanguageButton() {
        changeLanguageButton.imageToRightIfNotArabic()
    }
    
    func setupCollectionView() {
        sponsersCollectionView.dataSource = self
        sponsersCollectionView.delegate = self
        sponsersCollectionView.registerCell(cell: SponserCollectionViewCell.self)
        sponsersCollectionView.backgroundColor = .clear
        sponsersCollectionView.showsHorizontalScrollIndicator = false
        sponsersCollectionView.showsVerticalScrollIndicator = false
        if let layout = sponsersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

// MARK: - Selectors
extension LoginViewController {
    
    @IBAction
    private func changeLanguageButtonDidPressed(_ sender: UIButton) {
        presenter.performChangeLanguage()
    }
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.performValidate(withUsername: usernameTextField.text, password: passwordTextField.text)
    }
    
    @objc
    private func loginAsAgentDidPressed(_ sender: UITapGestureRecognizer) {
        presenter.performLoginAsAgent()
    }
    
    @IBAction
    private func forgotPasswordButtonDidPressed(_ sender: UIButton) {
        presenter.performForgetPassword()
    }
    
    @IBAction
    private func loginButtonDidPressed(_ sender: SpinnerButton) {
        view.endEditing(true)
        presenter.performLogin(withCard: usernameTextField.text, password: passwordTextField.text)
    }
    
    @IBAction
    private func createAccountButtonDidPressed(_ sender: UIButton) {
        presenter.performCreateNewAccount()
    }
    
    @IBAction
    private func skipButtonDidPressed(_ sender: UIButton) {
        presenter.perfromSkip()
    }
}

extension LoginViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.sponsersCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(at: indexPath) as SponserCollectionViewCell
        presenter.configureSponserCell(cell, atIndex: indexPath.item)
        return cell
    }
}

extension LoginViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectSponser(atIndex: indexPath.item)
    }
}

extension LoginViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (UIScreen.main.bounds.width - 40) * 0.8, height: 70)
    }
}
