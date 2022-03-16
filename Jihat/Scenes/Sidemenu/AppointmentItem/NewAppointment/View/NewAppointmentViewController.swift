//
//  NewAppointmentViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 30/09/2021.
//

import UIKit

final class NewAppointmentViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var addressTextField: UITextField! {
        didSet { addressTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var appointmentTextView: KMPlaceholderTextView! {
        didSet { appointmentTextView.delegate = self }
    }
    @IBOutlet private weak var appointmentLimitLabel: UILabel!
    @IBOutlet private weak var attachedDocumentsTextField: UITextField! {
        didSet { attachedDocumentsTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var startDateTextField: UITextField! {
        didSet {
            startDateTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
            startDateTextField.setDateInputViewDatePicker(target: self, selector: #selector(startDateTextFieldDateDidChanged(_:))) }
    }
    @IBOutlet private weak var startTimeTextField: UITextField! {
        didSet {
            startTimeTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
            startTimeTextField.setTimeInputViewDatePicker(target: self, selector: #selector(startTimeTextFieldTimeDidChanged(_:))) }
    }
    @IBOutlet private weak var alertTypeTextField: UITextField!{
        didSet {
            alertTypeTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) 
            alertTypeTextField.addPickerView(alertTypePickerView) }
    }
    @IBOutlet private weak var saveAppointmentButton: SpinnerButton!
    
    // MARK: - Variables
    var presenter: NewAppointmentPresenterProtocol!
    
    var _addressTextField: UITextField {
        return addressTextField
    }
    var _appointmentTextView: KMPlaceholderTextView {
        return appointmentTextView
    }
    var _appointmentLimitLabel: UILabel {
        return appointmentLimitLabel
    }
    var _attachedDocumentsTextField: UITextField {
        return attachedDocumentsTextField
    }
    var _startDateTextField: UITextField {
        return startDateTextField
    }
    var _startTimeTextField: UITextField {
        return startTimeTextField
    }
    var _alertTypeTextField: UITextField {
        return alertTypeTextField
    }
    private let alertTypePickerView = UIPickerView()
    private var alertTypePickerDataSourceDelegate: PickerView!
    var _saveAppointmentButton: SpinnerButton {
        return saveAppointmentButton
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupAppNavigationBar()
        setUpAlertTypePickerView()
        presenter.performObserveInputs(address: addressTextField.text, appointmentDetails: appointmentTextView.text, attachedDoucments: attachedDocumentsTextField.text, startDate: startDateTextField.text, startTime: startTimeTextField.text, alertType: alertTypeTextField.text)
        appointmentLimitLabel.text = "520 \("letter".localized())"
        
    }
    
}

// MARK: - Helpers
extension NewAppointmentViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
    
    func setUpAlertTypePickerView() {
        alertTypePickerDataSourceDelegate = PickerView(itemsCount: presenter.alertTypeCount, rawConfigurator: { [weak self] row -> String in
            self?.presenter.setAlertType(atIndex: row) ?? ""
        }, itemSelection: { [weak self] row in
            self?.presenter.didSelectAlertType(atIndex: row)
            self?.presenter.performObserveInputs(address: self?.addressTextField.text, appointmentDetails: self?.appointmentTextView.text, attachedDoucments: self?.attachedDocumentsTextField.text, startDate: self?.startDateTextField.text, startTime: self?.startTimeTextField.text, alertType: self?.alertTypeTextField.text)
        })
        alertTypePickerView.dataSource = alertTypePickerDataSourceDelegate
        alertTypePickerView.delegate = alertTypePickerDataSourceDelegate
    }
    
}

// MARK: - Selectors
extension NewAppointmentViewController {
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.performObserveInputs(address: addressTextField.text, appointmentDetails: appointmentTextView.text, attachedDoucments: attachedDocumentsTextField.text, startDate: startDateTextField.text, startTime: startTimeTextField.text, alertType: alertTypeTextField.text)
    }
    
    @objc
    private func startDateTextFieldDateDidChanged(_ sender: UIDatePicker) {
        presenter.performChangeStartDate(sender.date)
    }
    
    @objc
    private func startTimeTextFieldTimeDidChanged(_ sender: UIDatePicker) {
        presenter.performChangeStartTime(sender.date)
    }
    
    @IBAction
    private func attachDocumentButtonDidPressed(_ sender: UIButton) {
        presenter.performAttachDocuments()
    }
    
    @IBAction
    private func saveAppointmentButtonDidPressed(_ sender: SpinnerButton) {
        view.endEditing(true)
        presenter.performSaveAppointment(subject: addressTextField.text, details: appointmentTextView.text, startDate: startDateTextField.text, startTme: startTimeTextField.text)
    }
    
    @IBAction
    private func cancelButtonDidPressed(_ sender: Any) {
        presenter.performBack()
    }
    
}

// MARK: - UITextViewDelegate
extension NewAppointmentViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter.performObserveInputs(address: addressTextField.text, appointmentDetails: appointmentTextView.text, attachedDoucments: attachedDocumentsTextField.text, startDate: startDateTextField.text, startTime: startTimeTextField.text, alertType: alertTypeTextField.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: text)
        appointmentLimitLabel.text = "\(520 - updateText.count) \("letter".localized())"
        
        return updateText.count < 520
    }
    
}
