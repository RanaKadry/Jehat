//
//  MyCalendarItemCollectionViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 26/09/2021.
//

import UIKit

protocol MyCalendarItemCollectionViewCellDelegate: AnyObject {
    func showDetailsButtonPressed(atIndex index: Int)
}

protocol MyCalendarItemCollectionViewCellProtocol {
    func set(calendarDayDate: String)
    func set(calendarTitle: String)
    func showAttachmentsButton()
    func set(calendarTime: String)
}

final class MyCalendarItemCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var calendarDayDateLabel: UILabel!
    @IBOutlet private weak var calendarTitleLabel: UILabel!
    @IBOutlet private weak var attachmentsButton: UIButton!
    @IBOutlet private weak var calendarTimeLabel: UILabel!
    
    // MARK: - Variables
    var index: Int!
    weak var delegate: MyCalendarItemCollectionViewCellDelegate?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - Helpers
extension MyCalendarItemCollectionViewCell {
    
}

// MARK: - Selectors
extension MyCalendarItemCollectionViewCell {
    
    @IBAction
    private func showCalendarDetailsButtonDidPressed(_ sender: UIButton) {
        guard let index = index else { fatalError("Should Define Index First!!") }
        delegate?.showDetailsButtonPressed(atIndex: index)
    }
}

// MARK: - MyCalendarItemCollectionViewCellProtocol
extension MyCalendarItemCollectionViewCell: MyCalendarItemCollectionViewCellProtocol {
    
    func set(calendarDayDate: String) {
        calendarDayDateLabel.text = calendarDayDate
    }
    
    func set(calendarTitle: String) {
        calendarTitleLabel.text = calendarTitle
    }
    
    func showAttachmentsButton() {
        attachmentsButton.isHidden = false
    }
    
    func set(calendarTime: String) {
        calendarTimeLabel.text = calendarTime
    }
}
