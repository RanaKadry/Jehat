//
//  AddAttachmentsViewController+Delegates.swift
//  Jihat
//
//  Created by Peter Bassem on 03/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

extension AddAttachmentsViewController: AddAttachmentsViewProtocol {
    
    func showSaveButton() {
        _saveButton.animate(hidden: false)
    }
    
    func hideSaveButton() {
        _saveButton.animate(hidden: true)
    }
    
    func startLoadingOnSaveButton() {
        _saveButton.startAnimation()
    }
    
    func stopLoadingOnSaveButton() {
        _saveButton.stopAnimation()
    }
    
    func setPickedAttachmentsNumber(attachmentsNumber: String) {
        _attachedDocumentTextField.text = attachmentsNumber
        presenter.performValidateInputs(documents: _attachedDocumentTextField.text, images: _pickedImageTextField.text)
    }
    
    func setPickedImagesNumber(imagesNumber: String) {
        _pickedImageTextField.text = imagesNumber
        presenter.performValidateInputs(documents: _attachedDocumentTextField.text, images: _pickedImageTextField.text)
    }
}
