//
//  FilterItemTableViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 27/11/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

protocol FilterItemTableViewCellProtocol {
    func set(filterTitle: String)
    func showCheckMark()
    func removeCheckMark()
    
    func updateFilterTitleLabelLeadingConstraint()
    func updateFilterTitleLabelTrailingConstraint()
}

final class FilterItemTableViewCell: BaseTableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var filterItemTitleLabel: UILabel!
    @IBOutlet private weak var filterItemTitleLabelLeading: NSLayoutConstraint!
    @IBOutlet private weak var filterItemTitleLabelTrailing: NSLayoutConstraint!
    
    // MARK: - Variables

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
}

// MARK: - FilterItemTableViewCellProtocol
extension FilterItemTableViewCell: FilterItemTableViewCellProtocol {
    
    func set(filterTitle: String) {
        filterItemTitleLabel.text = filterTitle
    }
    
    func showCheckMark() {
        accessoryType = .checkmark
    }
    
    func removeCheckMark() {
        accessoryType = .none
    }
    
    func updateFilterTitleLabelLeadingConstraint() {
        filterItemTitleLabelLeading.constant = 16
    }
    
    func updateFilterTitleLabelTrailingConstraint() {
        filterItemTitleLabelTrailing.constant = -16
    }
}
