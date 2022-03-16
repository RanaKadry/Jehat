//
//  ChooseCandidateItemCollectionViewCell.swift
//  Jihat
//
//  Created by Ahmed Barghash on 14/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

protocol ChooseCandidateItemCollectionViewCellDelegate: AnyObject {
    func didSelectCandidate(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int)
    func didDeselectCandidate(_ cell: ChooseCandidateItemCollectionViewCell, atIndex index: Int)
}

protocol ChooseCandidateCollectionViewCellProtocol {
    func set(candidateName: String)
    func disableCooseCandidateCheckBox()
    func enableCooseCandidateCheckBox()
}

final class ChooseCandidateItemCollectionViewCell: BaseCollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var candidateNameLabel: UILabel!
    @IBOutlet private weak var chooseCandidateCheckBox: MBCheckBoxButton! {
        didSet { chooseCandidateCheckBox.ckbDelegate = self }
    }
    
    // MARK: - Variables
    var index: Int!
    weak var delegate: ChooseCandidateItemCollectionViewCellDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - Helpers

// MARK: - Selectors

// MARK: - ChooseCandidateItemCollectionViewCellProtocol
extension ChooseCandidateItemCollectionViewCell: ChooseCandidateCollectionViewCellProtocol {
    
    func set(candidateName: String) {
        candidateNameLabel.text = candidateName
    }
    
    func disableCooseCandidateCheckBox() {
        chooseCandidateCheckBox.isOn = false
    }
    
    func enableCooseCandidateCheckBox() {
        chooseCandidateCheckBox.isOn = true
    }
}

// MARK: - RadioButtonDelegate
extension ChooseCandidateItemCollectionViewCell: MBCheckBoxButtonDelegate {
    
    func mBCheckBoxButtonIsSelected(_ mBCheckBoxButton: MBCheckBoxButton, isSelected selected: Bool) {
        guard let index = index else { fatalError("MUST SELECT INDEX FIRST!") }
        selected ? delegate?.didSelectCandidate(self, atIndex: index) : delegate?.didDeselectCandidate(self, atIndex: index)
    }
}
