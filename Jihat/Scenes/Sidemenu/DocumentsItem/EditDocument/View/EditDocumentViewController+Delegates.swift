//
//  EditDocumentViewController+Delegates.swift
//  Jihat
//
//  Created Ahmed Barghash on 13/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension EditDocumentViewController: EditDocumentViewProtocol {
    
    func set(documentArabicName: String) {
        _documentArabicNameTextField.text = documentArabicName
    }
    
    func set(documentEnglishName: String) {
        _documentEnglishNameTextField.text = documentEnglishName
    }
    
    func set(documentNumber: String) {
        _documentNumberTextField.text = documentNumber
    }
    
    func set(documentEndDate: String) {
        _documentEndDateTextField.text = documentEndDate
    }
    
    func set(attachemtsCount: String) {
        _attachedDocumentNumberLabel.text = attachemtsCount
    }
    
    func showAddImagesButton() {
        _addImagesButton.animate(hidden: false)
    }
    
    func showAttachmentsImagesButton() {
        _addDocumentsButton.animate(hidden: false)
    }
    
    func refreshCollectionView() {
        setupCollectionView()
//        presenter.validateInputs(arabicName: _documentArabicNameTextField.text, englishName: _documentEnglishNameTextField.text, documentNumber: _documentNumberTextField.text, endDate: _documentEndDateTextField.text)
    }
    
    func enableEditDocumentArabicNameTextField() {
        _documentArabicNameTextField.isEnabled = true
        _documentArabicNameTextField.alpha = 1
    }
    
    func enableEditDocumentEnglishNameTextField() {
        _documentEnglishNameTextField.isEnabled = true
        _documentEnglishNameTextField.alpha = 1
    }
    
    func enableEditDocumentNumberTextField() {
        _documentNumberTextField.isEnabled = true
        _documentNumberTextField.alpha = 1
    }
    
    func enableEditEndDateTextField() {
        _documentEndDateTextField.isEnabled = true
        _documentEndDateTextField.alpha = 1
    }
    
    func setEndDate(endDate: String) {
        _documentEndDateTextField.text = endDate
    }
    
    func enableAttachmentsCollectionView() {
        _collectionView.isUserInteractionEnabled = true
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(popUpActionCell(_:)))
        _collectionView.addGestureRecognizer(longGesture)
    }
    
    func enableSaveChangesButton() {
        _saveButton.configureButton(true)
    }
    
    func disableSaveChangesButton() {
        _saveButton.configureButton(false)
    }
    
    func startLoadingOnSaveButton() {
        _saveButton.startAnimation()
    }
    
    func stopLoadingOnSaveButton() {
        _saveButton.stopAnimation()
    }
}
