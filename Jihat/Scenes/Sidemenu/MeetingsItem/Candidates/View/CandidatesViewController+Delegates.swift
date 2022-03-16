//
//  CandidatesViewController+Delegates.swift
//  Jihat
//
//  Created by Ahmed Barghash on 13/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//
//

import UIKit

extension CandidatesViewController: CandidatesViewProtocol {
    
    func removeStackViewTopConstraint() {
        _stackViewTopConstraint.constant = 0
    }
    
    func removeStackViewBottomConstraint() {
        _stackViewBottomConstraint.constant = 0
    }
    
    func hideMeetingSharesCountStackView() {
        _meetingSharesCountStackView.isHidden = true
    }
    
    func hideMeetingSharesTitlesStackView() {
        _meetingSharesTitlesStackView.isHidden = true
    }
    
    func set(meetingTitle: String) {
        _meetingTitleLabel.text = meetingTitle
    }
    
    func set(candidatesNumberOrSharesNumber: String) {
        _candidatesOrSharesNumberLabel.text = candidatesNumberOrSharesNumber
    }
    
    func set(chooseCandidateOrSharesNumber: String) {
        _chooseOrSharesNumberLabel.text = chooseCandidateOrSharesNumber
    }
    
    func refreshCandidatesSharesCollectionView() {
        setupCandidatesSharesCollectionView()
    }
    
    func refreshDisributeCandidatesSharesCollectionView() {
        setupDisributeCandidatesSharesCollectionView()
    }
    
    func refreshMultiDistributeCandidatesSharesCollectionView() {
        setupMultiDistributeCandidatesSharesCollectionView()
    }
    
    func refreshCollectionView() {
//        setupCollectionView()
    }
    
    func setupVoteRequiredButton() {
        _voteRequiredButton.backgroundColor = DesignSystem.Colors.primaryActionColor.color
        _voteRequiredButton.setTitleColor(DesignSystem.Colors.text1Color.color, for: .normal)
        _voteRequiredButton.setTitle("vote_required".localized(), for: .normal)
    }
    
    func setupVoteDoneButton() {
        _voteRequiredButton.backgroundColor = DesignSystem.Colors.backgroundSecondaryColor.color
        _voteRequiredButton.setTitleColor(DesignSystem.Colors.text3Color.color, for: .normal)
        _voteRequiredButton.setTitle("been_voted".localized(), for: .normal)
    }
    
    func enableVoteRequiredButton() {
        _voteRequiredButton.configureButton(true)
    }
    
    func disableVoteRequiredButton() {
        _voteRequiredButton.configureButton(false)
    }
    
    
}
