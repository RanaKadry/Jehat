//
//  MeetingTermCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 08/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

protocol MeetingTermCollectionViewCellDelegate: AnyObject {
    func voteButtonPresed(atIndex index: Int)
}

protocol MeetingTermCollectionViewCellProtocol {
    func set(voteNumbers: String)
    func set(approversNumbers: String)
    func set(disapprovesNumbers: String)
    func set(meetingTerm: String)
    func setupVoteRequiredButton()
    func setupVoteDoneButton(title: String)
}

final class MeetingTermCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var votesNumberLabel: UILabel!
    @IBOutlet private weak var approversNumberLabel: UILabel!
    @IBOutlet private weak var disapprovesNumberLabel: UILabel!
    @IBOutlet private weak var meetingTermsLabel: UILabel!
    @IBOutlet private weak var voteButton: UIButton!
    
    // MARK: - Variables
    var index: Int!
    weak var delegate: MeetingTermCollectionViewCellDelegate?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - Helpers
extension MeetingTermCollectionViewCell {
    
}

// MARK: - Helpers
extension MeetingTermCollectionViewCell {
    
    @IBAction
    private func voteButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { fatalError("index must be implemented") }
        delegate?.voteButtonPresed(atIndex: index)
    }
}

// MARK: - MeetingTermCollectionViewCellProtocol
extension MeetingTermCollectionViewCell: MeetingTermCollectionViewCellProtocol {
    
    func set(voteNumbers: String) {
        votesNumberLabel.text = voteNumbers
    }
    
    func set(approversNumbers: String) {
        approversNumberLabel.text = approversNumbers
    }
    
    func set(disapprovesNumbers: String) {
        disapprovesNumberLabel.text = disapprovesNumbers
    }
    
    func set(meetingTerm: String) {
        meetingTermsLabel.text = meetingTerm
    }
    
    func setupVoteRequiredButton() {
        voteButton.backgroundColor = DesignSystem.Colors.primaryActionColor.color
        voteButton.setTitleColor(DesignSystem.Colors.text1Color.color, for: .normal)
        voteButton.setTitle("vote_required".localized(), for: .normal)
    }
    
    func setupVoteDoneButton(title: String) {
        voteButton.backgroundColor = DesignSystem.Colors.backgroundSecondaryColor.color
        voteButton.setTitleColor(DesignSystem.Colors.text3Color.color, for: .normal)
        voteButton.setTitle(title.localized(), for: .normal)
    }
}
