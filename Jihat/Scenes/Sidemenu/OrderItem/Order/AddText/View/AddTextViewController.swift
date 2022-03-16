//
//  AddTextViewController.swift
//  Jihat
//
//  Created by Peter Bassem on 10/10/2021.
//

import UIKit

final class AddTextViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var blurVisualEffectView: UIVisualEffectView!
    @IBOutlet private weak var containerView: UIView! {
        didSet  { containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] }
    }
    @IBOutlet weak var textNoteTextView: PlaceholderTextView! {
        didSet {
            textNoteTextView.delegate = self
            detailsLimitLabel.text = "\(370.localized() ?? "") \("letter".localized())"
        }
    }
    @IBOutlet private weak var detailsLimitLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Variables
    var presenter: AddTextPresenterProtocol!
    
    var _saveButton: UIButton {
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
        setupTextNoteTextView()
        presenter.performValidateTextNote(empty: textNoteTextView.isTextEmpty)
    }
}

// MARK: - Helpers
extension AddTextViewController {
    
    
    private func setupTextNoteTextView() {
        textNoteTextView.textIsEmptyListener = { [weak self] empty in
            self?.presenter.performValidateTextNote(empty: empty)
        }
    }
}

// MARK: - Selectors
extension AddTextViewController {
    
    @objc
    private func tapGestureDidPressed(_ sender: UITapGestureRecognizer) {
        presenter.performBack()
    }
    
    @IBAction
    private func cancelButtonDidPressed(_ sender: UIButton) {
        presenter.performBack()
    }
    
    @IBAction
    private func saveButtonDidPressed(_ sender: UIButton) {
        presenter.performSaveButtonPressed(note: textNoteTextView.text)
    }
}

// MARK: - UITextViewDelegate
extension AddTextViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        presenter.performObserveInputs(entity: directedEntityTextField.text, orderType: orderTypeTextField.text, topic: topicTextFiled.text, details: detailsTextView.text, attachedDocuments: attachedDocumentsTextField.text, orderPriority: orderTypeTextField.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: text)
        detailsLimitLabel.text = "\((370 - updateText.count).localized() ?? "") \("letter".localized())"
        return updateText.count < 370
    }
}
