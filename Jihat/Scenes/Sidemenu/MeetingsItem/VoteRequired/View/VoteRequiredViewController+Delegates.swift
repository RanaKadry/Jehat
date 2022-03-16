//
//  VoteRequiredViewController+Delegates.swift
//  Jihat
//
//  Created by Ahmed Barghash on 05/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

extension VoteRequiredViewController: VoteRequiredViewProtocol {
    
    func set(voteNumbers: String) {
        _votesNumberLabel.text = voteNumbers
    }
    
    func set(approversNumbers: String) {
        _approversNumberLabel.text = approversNumbers
    }
    
    func set(disapprovesNumbers: String) {
        _disapprovesNumberLabel.text = disapprovesNumbers
    }
    
    func set(meetingTerm: String) {
        _meetingTermLabel.text = meetingTerm
    }
    
    func selectAgreeRadioButton() {
        _agreeRadioButton.isOn = true
    }
    
    func selectDisagreeRadioButton() {
        _disagreeRadioButton.isOn = true
    }
    
    func set(attachedFilesNumber: String) {
        _attachedDocumentTextField.text = attachedFilesNumber
    }
    
    func set(pickedImagesNumber: String) {
        _pickedImageTextField.text = pickedImagesNumber
    }
    
    func showLoadingOnVoteButton() {
        _voteButton.startAnimation()
    }
    
    func stopLoadingOnVoteButton() {
        _voteButton.stopAnimation()
    }
    
    func enableVoteButton() {
        _voteButton.configureButton(true)
    }
    
    func disableVoteButton() {
        _voteButton.configureButton(false)
    }
}
