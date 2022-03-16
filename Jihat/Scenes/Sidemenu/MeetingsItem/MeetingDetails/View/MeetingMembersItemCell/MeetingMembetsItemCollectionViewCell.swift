//
//  MeetingMembetsItemCollectionViewCell.swift
//  Jihat
//
//  Created by Ahmed Barghash on 05/11/2021.
//

import UIKit

protocol MeetingMembersCollectionViewCellProtocol {
    func set(memberNameAndStatus: String)
}

class MeetingMembetsItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var memberLabel: UILabel!
    
    // MARK: - Variables
    var _memberLabel: UILabel! {
        return memberLabel
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

// MARK: - Helpers

// MARK: - Selectors

// MARK: - MeetingMembersItemCollectionViewCellProtocol
extension MeetingMembetsItemCollectionViewCell: MeetingMembersCollectionViewCellProtocol {
    
    func set(memberNameAndStatus: String) {
        memberLabel.text = memberNameAndStatus
    }
    
}
