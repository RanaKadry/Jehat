//
//  AddNewDocumentsViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 12/10/2021.
//

import UIKit
import MobileCoreServices

final class AddNewDocumentsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var documentArabicNameTextField: UITextField! {
        didSet { documentArabicNameTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var documentEnglishNameTextField: UITextField! {
        didSet { documentEnglishNameTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var documentNumberTextField: UITextField! {
        didSet { documentNumberTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var endDateTextField: UITextField! {
        didSet {
            endDateTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged)
            endDateTextField.setDateInputViewDatePicker(target: self, selector: #selector(endDateTextFieldDateDidChanged(_:))) }
    }
    @IBOutlet private weak var attachedDocumentTextField: UITextField! {
        didSet { attachedDocumentTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var pickedImageTextField: UITextField! {
        didSet { pickedImageTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var saveButton: SpinnerButton!
    
    // MARK: - Variables
    var presenter: AddNewDocumentsPresenterProtocol!
    
    var _documentArabicNameTextField: UITextField{
        return documentArabicNameTextField
    }
    var _documentEnglishNameTextField: UITextField{
        return documentEnglishNameTextField
    }
    var _documentNumberTextField: UITextField{
        return documentNumberTextField
    }
    var _endDateTextField: UITextField {
        return endDateTextField
    }
    var _attachedDocumentTextField: UITextField{
        return attachedDocumentTextField
    }
    var _pickedImageTextField: UITextField{
        return pickedImageTextField
    }
    var _saveButton: SpinnerButton{
        return saveButton
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupAppNavigationBar()
        presenter.performObserveInputs(documentArabicName: documentArabicNameTextField.text, documentEnglishName: documentEnglishNameTextField.text, documentNumber: documentNumberTextField.text, endDate: endDateTextField.text, attachedDocuments: attachedDocumentTextField.text, pickedImage: pickedImageTextField.text)
    }
}

// MARK: - Helpers
extension AddNewDocumentsViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
}

// MARK: - Selectors
extension AddNewDocumentsViewController {
    
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.performObserveInputs(documentArabicName: documentArabicNameTextField.text, documentEnglishName: documentEnglishNameTextField.text, documentNumber: documentNumberTextField.text, endDate: endDateTextField.text, attachedDocuments: attachedDocumentTextField.text, pickedImage: pickedImageTextField.text)
    }
    
    @objc
    private func endDateTextFieldDateDidChanged(_ sender: UIDatePicker) {
        presenter.performChangeEndtDate(sender.date)
        presenter.performObserveInputs(documentArabicName: documentArabicNameTextField.text, documentEnglishName: documentEnglishNameTextField.text, documentNumber: documentNumberTextField.text, endDate: endDateTextField.text, attachedDocuments: attachedDocumentTextField.text, pickedImage: pickedImageTextField.text)
    }
    
    @IBAction
    private func attachDocumentButtonDidPressed(_ sender: UIButton) {
        presenter.performAttachDocumentsButtonPressed()
    }
    
    @IBAction
    private func pickUpImageButtonDidPressed(_ sender: UIButton) {
        presenter.performAttachImagesButtonPressed()
    }
    
    @IBAction
    private func saveButtonDidPressed(_ sender: SpinnerButton) {
        view.endEditing(true)
        presenter.performSaveDocument(arabicName: documentArabicNameTextField.text, englishName: documentEnglishNameTextField.text, number: documentNumberTextField.text, endDate: endDateTextField.text)
    }
}
