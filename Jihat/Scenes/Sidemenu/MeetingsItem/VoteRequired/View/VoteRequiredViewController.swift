//
//  VoteRequiredViewController.swift
//  Jihat
//
//  Created by Ahmed Barghash on 05/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final class VoteRequiredViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var appNavigationBar: AppNavigationBar!
    @IBOutlet private weak var votesNumberLabel: UILabel!
    @IBOutlet private weak var approversNumberLabel: UILabel!
    @IBOutlet private weak var disapprovesNumberLabel: UILabel!
    @IBOutlet private weak var meetingTermLabel: UILabel!
    @IBOutlet weak var agreeRadioButton: MBRadioButton!
    @IBOutlet weak var disagreeRadioButton: MBRadioButton!
    @IBOutlet private weak var commentTextView: PlaceholderTextView! {
        didSet {commentTextView.delegate = self}
    }
    @IBOutlet private weak var detailsLimitLabel: UILabel!
    @IBOutlet private weak var attachedDocumentTextField: UITextField!
    @IBOutlet private weak var pickedImageTextField: UITextField!
    @IBOutlet weak var voteButton: SpinnerButton!
    
    // MARK: - Variables
	var presenter: VoteRequiredPresenterProtocol!
    private let radioButtonGroup = MBRadioButtonContainer()
    private var agreementRadioButtonDelegate: AgreementRadioButtonDelegate!
    
    var _votesNumberLabel: UILabel!{
        return votesNumberLabel
    }
    var _approversNumberLabel: UILabel!{
        return approversNumberLabel
    }
    var _disapprovesNumberLabel: UILabel!{
        return disapprovesNumberLabel
    }
    var _meetingTermLabel: UILabel!{
        return meetingTermLabel
    }
    var _agreeRadioButton: MBRadioButton {
        return agreeRadioButton
    }
    var _disagreeRadioButton: MBRadioButton {
        return disagreeRadioButton
    }
    var _detailsLimitLabel: UILabel!{
        return detailsLimitLabel
    }
    var _commentTextView: PlaceholderTextView!{
        return commentTextView
    }
    var _attachedDocumentTextField: UITextField!{
        return attachedDocumentTextField
    }
    var _pickedImageTextField: UITextField!{
        return pickedImageTextField
    }
    var _voteButton: SpinnerButton {
        return voteButton
    }

    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupAppNavigationBar()
        detailsLimitLabel.text = "\((520.localized()) ?? "") \("letter".localized())"
        setupAgreementRadioButtonContainer()
        presenter.validateInputs()
    }
}

// MARK: - Helpers
extension VoteRequiredViewController {
    
    private func setupAppNavigationBar() {
        appNavigationBar.backButtonPressed = { [weak self] in
            self?.presenter.performBack()
        }
    }
    
    private func setupAgreementRadioButtonContainer() {
        radioButtonGroup.addButtons([agreeRadioButton, disagreeRadioButton])
        agreementRadioButtonDelegate = AgreementRadioButtonDelegate(agreeRadioButton: agreeRadioButton, disagreeRadioButton: disagreeRadioButton) { [weak self] (agreement) in
            self?.presenter.didSelectAgreement(agreement: agreement)
            self?.presenter.validateInputs()
        }
        radioButtonGroup.rdbDelegate = agreementRadioButtonDelegate
    }
}

// MARK: - Selectors
extension VoteRequiredViewController {
    
    @IBAction
    private func attachDocumentButtonDidPressed(_ sender: UIButton) {
        presenter.performAttachDocuments()
    }
    
    @IBAction
    private func pickUpImageButtonDidPressed(_ sender: UIButton) {
        presenter.performPickUpImages()
    }
    
    @IBAction
    private func voteButtonDidPressed(_ sender: SpinnerButton) {
        presenter.performVote(comment: commentTextView.text)
    }
}

// MARK: - UITextViewDelegate
extension VoteRequiredViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: text)
        detailsLimitLabel.text = "\(((520 - updateText.count).localized()) ?? "") \("letter".localized())"
        
        return updateText.count < 520
    }
}
