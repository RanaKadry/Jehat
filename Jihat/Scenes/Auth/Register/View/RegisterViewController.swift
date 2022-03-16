//
//  RegisterViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 17/09/2021.
//

import UIKit

final class RegisterViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var appNavigationBar: AppNavigationBar! {
        didSet { appNavigationBar.itemsCount = presenter.itemsCount }
    }
    @IBOutlet private weak var arabicFullnameTextField: UITextField! {
        didSet { configure(textField: arabicFullnameTextField) }
    }
    @IBOutlet private weak var englishFullnameTextField: UITextField! {
        didSet { configure(textField: englishFullnameTextField) }
    }
    @IBOutlet private weak var genderTextField: UITextField! {
        didSet { genderTextField.addPickerView(genderPickerView) }
    }
    @IBOutlet private weak var selectCountryStackViewTop: NSLayoutConstraint!
    @IBOutlet private weak var selectCountryStackViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var selectCountryStackView: UIStackView!
    @IBOutlet private weak var countryTextFieldTop: NSLayoutConstraint!
    @IBOutlet private weak var countryTextFieldHeight: NSLayoutConstraint!
    @IBOutlet private weak var countryTextField: UITextField! {
        didSet { countryTextField.delegate = self }
    }
    @IBOutlet private weak var identityTextField: UITextField! {
        didSet { configure(textField: identityTextField) }
    }
    @IBOutlet private weak var identityInfoButton: UIButton! {
        didSet { identityInfoButton.setTitle("", for: .normal) }
    }
    @IBOutlet private weak var passwordTextField: PasswordTextField! {
        didSet { configure(textField: passwordTextField) }
    }
    
    @IBOutlet private weak var mobilePhoneStackViewTop: NSLayoutConstraint!
    @IBOutlet private weak var mobilePhoneStackHeight: NSLayoutConstraint!
    @IBOutlet private weak var mobilePhoneStackView: UIStackView!
    @IBOutlet private weak var mobilePhoneTextFieldTop: NSLayoutConstraint!
    @IBOutlet private weak var mobilePhoneTextFieldHeight: NSLayoutConstraint!
    @IBOutlet private weak var mobilePhoneTextField: PhoneNumberTextField! {
        didSet {
            mobilePhoneTextField.phoneNumberDelegate = self
            mobilePhoneTextField.addTarget(self, action: #selector(mobilePhoneDidBeginEditing(_:)), for: .editingDidBegin)
            mobilePhoneTextField.addTarget(self, action: #selector(mobilePhoneDidEndEditing(_:)), for: .editingDidEnd)
        }
    }
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet { configure(textField: emailTextField) }
    }
    @IBOutlet private weak var createAccountButton: SpinnerButton!
    
    // MARK: - Variables
    var presenter: RegisterPresenterProtocol!
    
    var _appNavigationBar: AppNavigationBar {
        return appNavigationBar
    }
    var collectionViewDataSetup: CollectionView<AppNavigationItemCollectionViewCell>!
    
    var _arabicFullnameTextField: UITextField {
        return arabicFullnameTextField
    }
    var _englishFullnameTextField: UITextField {
        return englishFullnameTextField
    }
    
    var _genderTextField: UITextField {
        return genderTextField
    }
    private let genderPickerView = UIPickerView()
    private var genderPickerDataSourceDelegate: PickerView!
    var _selectCountryStackViewTop: NSLayoutConstraint {
        return selectCountryStackViewTop
    }
    var _selectCountryStackViewHeight: NSLayoutConstraint {
        return selectCountryStackViewHeight
    }
    var _selectCountryStackView: UIStackView {
        return selectCountryStackView
    }
    var _countryTextFieldTop: NSLayoutConstraint {
        return countryTextFieldTop
    }
    var _countryTextFieldHeight: NSLayoutConstraint {
        return countryTextFieldHeight
    }
    var _countryTextField: UITextField {
        return countryTextField
    }
    private let countriesPickerView = UIPickerView()
    var _countriesPickerView: UIPickerView {
        return countriesPickerView
    }
    
    var _identityTextField: UITextField {
        return identityTextField
    }
    var _passwordTextField: PasswordTextField {
        return passwordTextField
    }
    
    var _mobilePhoneStackViewTop: NSLayoutConstraint {
        return mobilePhoneStackViewTop
    }
    var _mobilePhoneStackHeight: NSLayoutConstraint {
        return mobilePhoneStackHeight
    }
    var _mobilePhoneStackView: UIStackView {
        return mobilePhoneStackView
    }
    var _mobilePhoneTextFieldTop: NSLayoutConstraint {
        return mobilePhoneTextFieldTop
    }
    var _mobilePhoneTextFieldHeight: NSLayoutConstraint {
        return mobilePhoneTextFieldHeight
    }
    var _mobilePhoneTextField: PhoneNumberTextField {
        return mobilePhoneTextField
    }
    var _emailTextField: UITextField {
        return emailTextField
    }
    var _createAccountButton: SpinnerButton {
        return createAccountButton
    }
    private var registerType: RegisterTypes = .insideCountry

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
//        setupAppNavigationBarCollectionView()
        setupGenderPickerView()
        presenter.performValidation(arabicFullname: arabicFullnameTextField.text, englishFullname: englishFullnameTextField.text, identity: identityTextField.text, password: passwordTextField.text, mobileValid: mobilePhoneTextField.isPhoneValid, email: emailTextField.text)
    }
}

// MARK: - Helpers
extension RegisterViewController {
    
    func setupAppNavigationBarCollectionView() {
        
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
//        guard let collectionViewWidth = collectionViewWidth else { return }
        presenter.didSelectNavigationBarCellItem(atIndex: 0)
        collectionViewDataSetup = CollectionView(itemsCount: presenter.itemsCount, itemConfigurator: { [weak self] cell, index in
            self?.presenter.configureNavigationBarCellItem(cell, atIndex: index)
        }, itemSelector: { [weak self] index in
            self?.appNavigationBar.selectedIndex = index
            self?.appNavigationBar.itemSelected()
            self?.registerType = RegisterTypes.allCases[index]
            self?.presenter.performValidation(arabicFullname: self?.arabicFullnameTextField.text, englishFullname: self?.englishFullnameTextField.text, identity: self?.identityTextField.text, password: self?.passwordTextField.text, mobileValid: self?.mobilePhoneTextField.isPhoneValid ?? false, email: self?.emailTextField.text)
            self?.presenter.didSelectNavigationBarCellItem(atIndex: index)
        }, itemSize: .init(width: UIScreen.main.bounds.width / CGFloat(presenter.itemsCount), height: appNavigationBar._collectionView.frame.size.height), itemSpacing: 0)
        appNavigationBar._collectionView.dataSource = collectionViewDataSetup
        appNavigationBar._collectionView.delegate = collectionViewDataSetup
        appNavigationBar._collectionView.registerCell(cell: AppNavigationItemCollectionViewCell.self)
        appNavigationBar._collectionView.showsHorizontalScrollIndicator = false
        appNavigationBar._collectionView.showsVerticalScrollIndicator = false
        if let layout = appNavigationBar._collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    private func configure(textField: UITextField) {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
    }
    
    private func update(textField: UITextField, isSelected: Bool) {
        textField.borderWidth = isSelected ? 0.2 : 0.5
        textField.borderColor = isSelected ? DesignSystem.Colors.secondaryBorderColor.color : DesignSystem.Colors.text4Color.color
        textField.shadow_Color = isSelected ? DesignSystem.Colors.primaryShadow.color : .clear
        textField.shadowRadius = isSelected ? 5 : 0
        textField.shadowOffsetX = 0
        textField.shadowOffsetY = 0
    }
    
    private func setupGenderPickerView() {
        genderPickerDataSourceDelegate = PickerView(itemsCount: presenter.gendersCount, rawConfigurator: { [weak self] row in
            self?.presenter.setGender(atIndex: row) ?? ""
        }, itemSelection: { [weak self] row in
            self?.presenter.didSelectGender(atIndex: row)
            self?.presenter.performValidation(arabicFullname: self?.arabicFullnameTextField.text, englishFullname: self?.englishFullnameTextField.text, identity: self?.identityTextField.text, password: self?.passwordTextField.text, mobileValid: self?.mobilePhoneTextField.isPhoneValid ?? false, email: self?.emailTextField.text)
        })
        genderPickerView.dataSource = genderPickerDataSourceDelegate
        genderPickerView.delegate = genderPickerDataSourceDelegate
    }
}

// MARK: - Selectors
extension RegisterViewController {
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.performValidation(arabicFullname: arabicFullnameTextField.text, englishFullname: englishFullnameTextField.text, identity: identityTextField.text, password: passwordTextField.text, mobileValid: mobilePhoneTextField.isPhoneValid, email: emailTextField.text)
    }
    
    @IBAction
    private func identityInformationButtonDidPressed(_ sender: UIButton) {
        presenter.performIdentityInformation()
    }
    
    @objc
    private func mobilePhoneDidBeginEditing(_ sender: PhoneNumberTextField) {
        update(textField: sender, isSelected: true)
    }
    
    @objc
    private func mobilePhoneDidEndEditing(_ sender: PhoneNumberTextField) {
        update(textField: sender, isSelected: false)
    }
    
    @IBAction
    private func createNewAccountButtonDidPressed(_ sender: UIButton) {
        view.endEditing(true)
        presenter.performRegister(arabicName: arabicFullnameTextField.text, englishName: englishFullnameTextField.text, identity: identityTextField.text, password: passwordTextField.text, phone: mobilePhoneTextField.formattedPhone, email: emailTextField.text)
    }
}

// MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == countryTextField {
            presenter.performShowNationalities()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        update(textField: textField, isSelected: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        update(textField: textField, isSelected: false)
    }
}

// MARK: - PhoneNumberTextFieldDelegate
extension RegisterViewController: PhoneNumberTextFieldDelegate {
    func phoneNumberTextFieldIsValidPhone(_ isValid: Bool) {
        presenter.performValidation(arabicFullname: arabicFullnameTextField.text, englishFullname: englishFullnameTextField.text, identity: identityTextField.text, password: passwordTextField.text, mobileValid: isValid, email: emailTextField.text)
    }
    
    func phoneNumberTextFieldDisplayCountriesListViewController() {
        presenter.performShowCountriesList()
    }
}
