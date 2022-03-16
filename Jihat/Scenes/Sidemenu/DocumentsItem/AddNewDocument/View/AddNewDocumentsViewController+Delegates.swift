//
//  AddNewDocumentsViewController+Delegates.swift
//  Jihat
//
//  Created Ahmed Barghash on 12/10/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension AddNewDocumentsViewController: AddNewDocumentsViewProtocol {
    
    func enableSaveButton() {
        _saveButton.configureButton(true)
    }
    
    func disableSaveButton() {
        _saveButton.configureButton(false)
    }
    
    func setEndDate(endDate: String) {
        _endDateTextField.text = endDate
    }
    
    func setPickedAttachmentsNumber(attachmentsNumber: String) {
        _attachedDocumentTextField.text = attachmentsNumber
        presenter.performObserveInputs(documentArabicName: _documentArabicNameTextField.text, documentEnglishName: _documentEnglishNameTextField.text, documentNumber: _documentNumberTextField.text, endDate: _endDateTextField.text, attachedDocuments: _attachedDocumentTextField.text, pickedImage: _pickedImageTextField.text)
    }
    
    func setPickedImagesNumber(imagesNumber: String) {
        _pickedImageTextField.text = imagesNumber
        presenter.performObserveInputs(documentArabicName: _documentArabicNameTextField.text, documentEnglishName: _documentEnglishNameTextField.text, documentNumber: _documentNumberTextField.text, endDate: _endDateTextField.text, attachedDocuments: _attachedDocumentTextField.text, pickedImage: _pickedImageTextField.text)
    }
    
    func startLoadingOnSaveButton() {
        _saveButton.startAnimation()
    }
    
    func stopLoadingOnSaveButton() {
        _saveButton.stopAnimation()
    }
}
