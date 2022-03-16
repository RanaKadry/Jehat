//
//  ProfileViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 25/09/2021.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var residentLabel: UILabel!
    @IBOutlet private weak var nationalityTextField: UITextField! {
        didSet { nationalityTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var nationalityPickerView: UIPickerView!
    @IBOutlet private weak var arabicNameTextField: UITextField! {
        didSet { arabicNameTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var englishNameTextField: UITextField! {
        didSet { englishNameTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var genderTextField: UITextField! {
        didSet { genderTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var genderPickerView: UIPickerView!
    @IBOutlet private weak var mobileTextField: PhoneNumberTextField! {
        didSet { mobileTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet { emailTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var idNumberTextField: UITextField! {
        didSet { idNumberTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var addressTextField: UITextField! {
        didSet { addressTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var faxTextField: UITextField! {
        didSet { faxTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var saveChangesButton: SpinnerButton!
    
    // MARK: - Variables
    var presenter: ProfilePresenterProtocol!
    
    var _residentLabel: UILabel!{
        return residentLabel
    }
    var _nationalityTextField: UITextField!{
        return nationalityTextField
    }
    var _nationalityPickerView: UIPickerView!{
        return nationalityPickerView
    }
    var _arabicNameTextField: UITextField! {
        return arabicNameTextField
    }
    var _englishNameTextField: UITextField {
        return englishNameTextField
    }
    var _genderTextField: UITextField!{
        return genderTextField
    }
    var _genderPickerView: UIPickerView!{
        return genderPickerView
    }
    var _mobileTextField: PhoneNumberTextField! {
        return mobileTextField
    }
    var _emailTextField: UITextField {
        return emailTextField
    }
    var _idNumberTextField: UITextField! {
        return idNumberTextField
    }
    var _addressTextField: UITextField! {
        return addressTextField
    }
    var _faxTextField: UITextField! {
        return faxTextField
    }
    var _saveChangesButton: SpinnerButton! {
        return saveChangesButton
    }
    
    private var nationaltyPickerDataSourceDelegate: PickerView!
    private var genderPickerDataSourceDelegate: PickerView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupAppNavigationBar()
        setupNationaltyPickerView()
        setUpGenderPickerView()
        presenter.performObserveInputs(nationality: nationalityTextField.text, gender: genderTextField.text, arabicName: arabicNameTextField.text, englishName: englishNameTextField.text, mobile: mobileTextField.formattedPhone, mobileIsValid: mobileTextField.isPhoneValid, email: emailTextField.text, id: idNumberTextField.text, address: addressTextField.text, fax: faxTextField.text)
    }
}

// MARK: - Helpers
extension ProfileViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performDiscardChanges()
        }
    }
    
    func setupNationaltyPickerView() {
        nationaltyPickerDataSourceDelegate = PickerView(itemsCount: presenter.nationalitiesCount, rawConfigurator: { [weak self] (row) -> String in
            self?.presenter.configureNatiolaitiesRow(atIndex: row) ?? ""
        }, itemSelection: { [weak self] (row) in
            self?.presenter.didselectNationality(atIndex: row)
            self?.presenter.performObserveInputs(nationality: self?.nationalityTextField.text, gender: self?.genderTextField.text, arabicName: self?.arabicNameTextField.text, englishName: self?.englishNameTextField.text, mobile: self?.mobileTextField.formattedPhone, mobileIsValid: self?.mobileTextField.isPhoneValid ?? false, email: self?.emailTextField.text, id: self?.idNumberTextField.text, address: self?.addressTextField.text, fax: self?.faxTextField.text)
        })
        nationalityPickerView.dataSource = nationaltyPickerDataSourceDelegate
        nationalityPickerView.delegate = nationaltyPickerDataSourceDelegate
    }
    
    private func setUpGenderPickerView() {
        genderPickerDataSourceDelegate = PickerView(itemsCount: presenter.gendersCount, rawConfigurator: { [weak self] (row) -> String in
            self?.presenter.configureGendersRow(atIndex: row) ?? ""
        }, itemSelection: { [weak self] (row) in
            self?.presenter.didSelectGender(atIndex: row)
            self?.presenter.performObserveInputs(nationality: self?.nationalityTextField.text, gender: self?.genderTextField.text, arabicName: self?.arabicNameTextField.text, englishName: self?.englishNameTextField.text, mobile: self?.mobileTextField.formattedPhone, mobileIsValid: self?.mobileTextField.isPhoneValid ?? false, email: self?.emailTextField.text, id: self?.idNumberTextField.text, address: self?.addressTextField.text, fax: self?.faxTextField.text)
        })
        genderPickerView.dataSource = genderPickerDataSourceDelegate
        genderPickerView.delegate = genderPickerDataSourceDelegate
    }
    
}

// MARK: - Selectors
extension ProfileViewController {
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.performObserveInputs(nationality: nationalityTextField.text, gender: genderTextField.text, arabicName: arabicNameTextField.text, englishName: englishNameTextField.text, mobile: mobileTextField.formattedPhone, mobileIsValid: mobileTextField.isPhoneValid, email: emailTextField.text, id: idNumberTextField.text, address: addressTextField.text, fax: faxTextField.text)
    }
    
    @IBAction
    private func editArabicNameButtonDidPressed(_ sender: UIButton) {
        presenter.performEditArabicName()
    }
    
    @IBAction
    private func editEnglishNameButtonDidPressed(_ sender: UIButton) {
        presenter.performEditEnglishName()
    }
    
    @IBAction
    private func editMobileButtonDidPressed(_ sender: UIButton) {
        presenter.performEditMobile()
    }
    
    @IBAction
    private func editEmailButtonDidPressed(_ sender: UIButton) {
        presenter.performEditEmail()
    }
    
    @IBAction
    private func editIdNumberButtonDidPressed(_ sender: UIButton) {
        presenter.performEditIdNumber()
    }
    
    @IBAction
    private func editAddressButtonDidPressed(_ sender: UIButton) {
        presenter.performEditAddress()
    }
    
    @IBAction
    private func editFaxButtonDidPressed(_ sender: UIButton) {
        presenter.performEditFax()
    }
    
    @IBAction
    private func saveButtonDidPressed(_ sender: UIButton) {
        presenter.performSaveChanges(arabicName: arabicNameTextField.text, englishName: englishNameTextField.text, phone: mobileTextField.formattedPhone, email: emailTextField.text, identificationCard: idNumberTextField.text, address: addressTextField.text, fax: faxTextField.text)
    }
    
    @IBAction
    private func discardButtonDidPressed(_ sender: UIButton) {
        presenter.performDiscardChanges()
    }
    
    @IBAction
    private func editNationalityButtonDidPressed(_ sender: UIButton) {
        presenter.showNationality()
    }
    
    @IBAction
    private func editGenderButtonDidPressed(_ sender: UIButton) {
        presenter.showGender()
    }
}

// MARK: - UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

// MARK: - PhoneNumberTextFieldDelegate
extension ProfileViewController: PhoneNumberTextFieldDelegate {
    func phoneNumberTextFieldIsValidPhone(_ isValid: Bool) {
        presenter.performObserveInputs(nationality: nationalityTextField.text, gender: genderTextField.text, arabicName: arabicNameTextField.text, englishName: englishNameTextField.text, mobile: mobileTextField.formattedPhone, mobileIsValid: isValid, email: emailTextField.text, id: idNumberTextField.text, address: addressTextField.text, fax: faxTextField.text)
    }
    
    func phoneNumberTextFieldDisplayCountriesListViewController() {
        presenter.performShowCountriesList()
    }
}
