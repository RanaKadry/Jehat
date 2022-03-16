//
//  DirectedEntityItemTableViewCell.swift
//  Jihat
//
//  Created by Peter Bassem on 20/12/2021.
//  Copyright © 2021 Jehat. All rights reserved.
//

import UIKit

protocol DirectedEntityItemTableViewCellProtocol {
    func set(departmentTitle: String)
}

final class DirectedEntityItemTableViewCell: BaseTableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var departmentTitleLabel: UILabel!
    
    // MARK: - Variables

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - DirectedEntityItemTableViewCellProtocol
extension DirectedEntityItemTableViewCell: DirectedEntityItemTableViewCellProtocol {
    
    func set(departmentTitle: String) {
        departmentTitleLabel.text = departmentTitle
    }
}
