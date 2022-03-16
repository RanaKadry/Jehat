//
//  MyMeetingItemCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 26/09/2021.
//

import UIKit

protocol MyMeetingItemCollectionViewCellDelegate: AnyObject {
    func showDetailsButtonPressed(atIndex index: Int)
}

protocol MyMeetingItemCollectionViewCellProtocol {
    func set(meetingDayDate: String)
    func set(meetingTitle: String)
    func set(meetingStatus: String)
    func set(meetingTime: String)
}

final class MyMeetingItemCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var meetingDayDateLabel: UILabel!
    @IBOutlet private weak var meetingTitleLabel: UILabel!
    @IBOutlet private weak var meetingStatusLabel: UILabel!
//    {
//        didSet { meetingStatusLabel.textAlignment = LocalizationHelper.isArabic() ? .left : .right }
//    }
    @IBOutlet private weak var meetingTimeLabel: UILabel!
    
    // MARK: - Variables
    var index: Int!
    weak var delegate: MyMeetingItemCollectionViewCellDelegate?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - Helpers
extension MyMeetingItemCollectionViewCell {
    
}

// MARK: - Selectors
extension MyMeetingItemCollectionViewCell {
    
    @IBAction
    private func showMeetingDetailsButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { fatalError("Should Define Index First!!") }
        delegate?.showDetailsButtonPressed(atIndex: index)
    }
}

// MARK: - MyMeetingItemCollectionViewCellProtocol
extension MyMeetingItemCollectionViewCell: MyMeetingItemCollectionViewCellProtocol {
    
    func set(meetingDayDate: String) {
        meetingDayDateLabel.text = meetingDayDate
    }
    
    func set(meetingTitle: String) {
        meetingTitleLabel.text = meetingTitle
    }
    
    func set(meetingStatus: String) {
        meetingStatusLabel.text = meetingStatus
    }
    
    func set(meetingTime: String) {
        meetingTimeLabel.text = meetingTime
    }
}
