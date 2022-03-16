//
//  AddAttachmentsViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 03/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

final class AddAttachmentsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var blurVisualEffectView: UIVisualEffectView!
    @IBOutlet private weak var containerView: UIView! {
        didSet  { containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] }
    }
    @IBOutlet private weak var textNoteTextView: PlaceholderTextView!
    @IBOutlet private weak var attachedDocumentTextField: UITextField! {
        didSet { attachedDocumentTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var pickedImageTextField: UITextField! {
        didSet { pickedImageTextField.addTarget(self, action: #selector(textFieldValueDidChanged(_:)), for: .editingChanged) }
    }
    @IBOutlet private weak var saveButton: SpinnerButton!
    
    // MARK: - Variables
	var presenter: AddAttachmentsPresenterProtocol!
    
    var _attachedDocumentTextField: UITextField{
        return attachedDocumentTextField
    }
    var _pickedImageTextField: UITextField{
        return pickedImageTextField
    }
    var _saveButton: SpinnerButton {
        return saveButton
    }
    
    private lazy var tapGesture: TapGestureRecognizer = {
        let gestureRecognizer = TapGestureRecognizer(target: self, action: #selector(tapGestureDidPressed(_:)))
        return gestureRecognizer
    }()

    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
        blurVisualEffectView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Helpers
extension AddAttachmentsViewController {
    
}

// MARK: - Selectors
extension AddAttachmentsViewController {
    
    @objc
    private func tapGestureDidPressed(_ sender: UITapGestureRecognizer) {
        presenter.performBack()
    }
 
    @objc
    private func textFieldValueDidChanged(_ sender: UITextField) {
        presenter.performValidateInputs(documents: attachedDocumentTextField.text, images: pickedImageTextField.text)
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
    private func cancelButtonDidPressed(_ sender: UIButton) {
        presenter.performBack()
    }
    
    @IBAction
    private func saveButtonDidPressed(_ sender: SpinnerButton) {
        presenter.performSaveButtonPressed(note: textNoteTextView.text)
    }
}
